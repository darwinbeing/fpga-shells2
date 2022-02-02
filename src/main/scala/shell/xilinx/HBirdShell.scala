// See LICENSE for license details.
package sifive.fpgashells.shell.xilinx.hbirdshell

import Chisel._
import chisel3.{Input, Output, RawModule, withClockAndReset}
import chisel3.experimental.{attach, Analog}

import freechips.rocketchip.config._
import freechips.rocketchip.devices.debug._
import freechips.rocketchip.util.{SyncResetSynchronizerShiftReg, ElaborationArtefacts, HeterogeneousBag}

import sifive.blocks.devices.gpio._
import sifive.blocks.devices.pwm._
import sifive.blocks.devices.spi._
import sifive.blocks.devices.uart._
import sifive.blocks.devices.pinctrl.{BasePin}
import sifive.blocks.devices.chiplink._

import sifive.fpgashells.devices.xilinx.xilinxhbirdmig._
// import sifive.fpgashells.ip.xilinx.{IBUFG, IOBUF, PULLUP, mmcm, reset_sys, PowerOnResetFPGAOnly}
import sifive.fpgashells.ip.xilinx.{IBUFG, IOBUF, PULLUP, PowerOnResetFPGAOnly, Series7MMCM, hbird_reset}

import sifive.fpgashells.clocks._
//-------------------------------------------------------------------------
// HBirdShell
//-------------------------------------------------------------------------

trait HasDDR3 { this: HBirdShell =>

  require(!p.lift(MemoryXilinxDDRKey).isEmpty)
  val ddr = IO(new XilinxHBirdMIGPads(p(MemoryXilinxDDRKey)))

  def connectMIG(dut: HasMemoryXilinxHBirdMIGModuleImp): Unit = {
    // Clock & Reset
    dut.xilinxhbirdmig.sys_clk_i := clk200.asUInt
    mig_clock                    := dut.xilinxhbirdmig.ui_clk
    mig_sys_reset                := dut.xilinxhbirdmig.ui_clk_sync_rst
    mig_mmcm_locked              := dut.xilinxhbirdmig.mmcm_locked
    dut.xilinxhbirdmig.aresetn   := mig_resetn
    dut.xilinxhbirdmig.sys_rst   := sys_reset

    ddr <> dut.xilinxhbirdmig
  }
}

abstract class HBirdShell(implicit val p: Parameters) extends RawModule {

  //-----------------------------------------------------------------------
  // Interface
  //-----------------------------------------------------------------------

  // Clock & Reset
  val CLK100MHZ    = IO(Input(Clock()))
  val CLK32768KHZ  = IO(Input(Clock()))
  val fpga_rst     = IO(Input(Bool()))
  val mcu_rst      = IO(Input(Bool()))

  // Green LEDs
  val led_0        = IO(Analog(1.W))
  val led_1        = IO(Analog(1.W))
  val led_2        = IO(Analog(1.W))

  // Buttons
  val mcu_wakeup   = IO(Analog(1.W))

  // Dedicated QSPI interface
  val qspi_cs      = IO(Analog(1.W))
  val qspi_sck     = IO(Analog(1.W))
  val qspi_dq      = IO(Vec(4, Analog(1.W)))

  // UART0
  val uart_rxd_out = IO(Analog(1.W))
  val uart_txd_in  = IO(Analog(1.W))

  // JTAG
  val mcu_TDO      = IO(Analog(1.W))     // TDO
  val mcu_TCK      = IO(Analog(1.W))     // TCK
  val mcu_TDI      = IO(Analog(1.W))     // TDI
  val mcu_TMS      = IO(Analog(1.W))     // TMS

  // General Purpose I/O Pins
  val gpio         = IO(Vec(32, Analog(1.W)))

  // JD (used for JTAG connection)
  val jd_6         = IO(Analog(1.W))  // SRST_n

  //-----------------------------------------------------------------------
  // Wire declrations
  //-----------------------------------------------------------------------

  val mmcm_locked    = Wire(Bool())

  val reset_core     = Wire(Bool())
  val reset_bus      = Wire(Bool())
  val reset_periph   = Wire(Bool())
  val reset_intcon_n = Wire(Bool())
  val reset_periph_n = Wire(Bool())

  val SRST_n         = Wire(Bool())

  val dut_jtag_TCK   = Wire(Clock())
  val dut_jtag_TMS   = Wire(Bool())
  val dut_jtag_TDI   = Wire(Bool())
  val dut_jtag_TDO   = Wire(Bool())
  val dut_jtag_reset = Wire(Bool())
  val dut_ndreset    = Wire(Bool())

  val ck_rst         = Wire(Bool())
  val reset          = Wire(Bool())

  val sys_clock       = Wire(Clock())
  val sys_reset       = Wire(Bool())

  val dut_clock       = Wire(Clock())
  val dut_reset       = Wire(Bool())
  val dut_resetn      = Wire(Bool())

  val do_reset        = Wire(Bool())

  val mig_mmcm_locked = Wire(Bool())
  val mig_sys_reset   = Wire(Bool())

  val mig_clock       = Wire(Clock())
  val mig_reset       = Wire(Bool())
  val mig_resetn      = Wire(Bool())

  //-----------------------------------------------------------------------
  // System clock and reset
  //-----------------------------------------------------------------------

  // Clock that drives the clock generator and the MIG
  sys_clock := CLK100MHZ

  // Allow the debug module to reset everything. Resets the MIG
  ck_rst    := fpga_rst & mcu_rst
  reset     := !ck_rst
  sys_reset := reset | dut_ndreset

  //-----------------------------------------------------------------------
  // Clock Generator
  //-----------------------------------------------------------------------

  //25MHz and multiples
  val hbird_sys_clock_mmcm0 = Module(new Series7MMCM(PLLParameters(
    "hbird_sys_clock_mmcm2",
    PLLInClockParameters(100, 50),
    Seq(
      PLLOutClockParameters(12.5),
      PLLOutClockParameters(25),
      PLLOutClockParameters(37.5),
      PLLOutClockParameters(50),
      PLLOutClockParameters(200),
      PLLOutClockParameters(150.00),
      PLLOutClockParameters(100, 180)))))

  hbird_sys_clock_mmcm0.io.clk_in1 := sys_clock
  hbird_sys_clock_mmcm0.io.reset   := reset
  val hbird_sys_clock_mmcm0_locked = hbird_sys_clock_mmcm0.io.locked
  val Seq(clk12_5, clk25, clk37_5, clk50, clk200, clk150, clk100_180) = hbird_sys_clock_mmcm0.getClocks

  //65MHz and multiples
  val hbird_sys_clock_mmcm1 = Module(new Series7MMCM(PLLParameters(
    "hbird_sys_clock_mmcm1",
    PLLInClockParameters(100, 50),
    Seq(
      PLLOutClockParameters(32.5),
      PLLOutClockParameters(65, 180)))))

  hbird_sys_clock_mmcm1.io.clk_in1 := sys_clock
  hbird_sys_clock_mmcm1.io.reset   := reset
  val clk32_5              = hbird_sys_clock_mmcm1.io.clk_out1
  val clk65                = hbird_sys_clock_mmcm1.io.clk_out2
  val hbird_sys_clock_mmcm1_locked = hbird_sys_clock_mmcm1.io.locked

  // DUT clock
  dut_clock := clk37_5

  //-----------------------------------------------------------------------
  // System reset
  //-----------------------------------------------------------------------

  do_reset             := !mig_mmcm_locked || mig_sys_reset || !hbird_sys_clock_mmcm0_locked ||
                          !hbird_sys_clock_mmcm1_locked
  mig_resetn           := !mig_reset
  dut_resetn           := !dut_reset

  val safe_reset = Module(new hbird_reset)

  safe_reset.io.areset := do_reset
  safe_reset.io.clock1 := mig_clock
  mig_reset            := safe_reset.io.reset1
  safe_reset.io.clock2 := dut_clock
  dut_reset            := safe_reset.io.reset2

  //overrided in connectMIG
  //provide defaults to allow above reset sequencing logic to work without both
  mig_clock            := dut_clock
  mig_mmcm_locked      := UInt("b1")

  //-----------------------------------------------------------------------
  // SPI Flash
  //-----------------------------------------------------------------------

  def connectSPIFlash(dut: HasPeripherySPIFlashModuleImp): Unit = {
    val qspiParams = p(PeripherySPIFlashKey)
    if (!qspiParams.isEmpty) {
      val qspi_params = qspiParams(0)
      val qspi_pins = Wire(new SPIPins(() => {new BasePin()}, qspi_params))

      SPIPinsFromPort(qspi_pins,
        dut.qspi(0),
        dut_clock,
        dut_reset,
        syncStages = qspi_params.defaultSampleDel
      )

      IOBUF(qspi_sck, dut.qspi(0).sck)
      IOBUF(qspi_cs,  dut.qspi(0).cs(0))

      (qspi_dq zip qspi_pins.dq).foreach {
        case(a, b) => IOBUF(a,b)
      }
    }
  }

  //---------------------------------------------------------------------
  // Debug JTAG
  //---------------------------------------------------------------------

  def connectDebugJTAG(dut: HasPeripheryDebugModuleImp): SystemJTAGIO = {

    //-------------------------------------------------------------------
    // JTAG Reset
    //-------------------------------------------------------------------

    val jtag_power_on_reset = PowerOnResetFPGAOnly(dut_clock)

    dut_jtag_reset := jtag_power_on_reset

    //-------------------------------------------------------------------
    // JTAG IOBUFs
    //-------------------------------------------------------------------

    dut_jtag_TCK  := IBUFG(IOBUF(mcu_TCK).asClock)

    dut_jtag_TMS  := IOBUF(mcu_TMS)
    PULLUP(mcu_TMS)

    dut_jtag_TDI  := IOBUF(mcu_TDI)
    PULLUP(mcu_TDI)

    IOBUF(mcu_TDO, dut_jtag_TDO)

    SRST_n := IOBUF(jd_6)
    PULLUP(jd_6)

    //-------------------------------------------------------------------
    // JTAG PINS
    //-------------------------------------------------------------------

    val djtag     = dut.debug.get.systemjtag.get

    djtag.jtag.TCK := dut_jtag_TCK
    djtag.jtag.TMS := dut_jtag_TMS
    djtag.jtag.TDI := dut_jtag_TDI
    dut_jtag_TDO   := djtag.jtag.TDO.data

    djtag.mfr_id   := p(JtagDTMKey).idcodeManufId.U(11.W)

    djtag.reset    := dut_jtag_reset
    dut_ndreset    := dut.debug.get.ndreset

    djtag
  }

  //---------------------------------------------------------------------
  // UART
  //---------------------------------------------------------------------

  def connectUART(dut: HasPeripheryUARTModuleImp): Unit = {
    val uartParams = p(PeripheryUARTKey)
    if (!uartParams.isEmpty) {
      IOBUF(uart_rxd_out, dut.uart(0).txd)
      dut.uart(0).rxd := IOBUF(uart_txd_in)
    }
  }

}
