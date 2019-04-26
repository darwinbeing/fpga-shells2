// See LICENSE for license details.
package sifive.fpgashells.devices.xilinx.xilinxhbirdmig

import Chisel._
import freechips.rocketchip.config._
import freechips.rocketchip.subsystem.BaseSubsystem
import freechips.rocketchip.diplomacy.{LazyModule, LazyModuleImp, AddressRange}

case object MemoryXilinxDDRKey extends Field[XilinxHBirdMIGParams]

trait HasMemoryXilinxHBirdMIG { this: BaseSubsystem =>
  val module: HasMemoryXilinxHBirdMIGModuleImp

  val xilinxhbirdmig = LazyModule(new XilinxHBirdMIG(p(MemoryXilinxDDRKey)))

  xilinxhbirdmig.node := mbus.toDRAMController(Some("xilinxhbirdmig"))()
}

trait HasMemoryXilinxHBirdMIGBundle {
  val xilinxhbirdmig: XilinxHBirdMIGIO
  def connectXilinxHBirdMIGToPads(pads: XilinxHBirdMIGPads) {
    pads <> xilinxhbirdmig
  }
}

trait HasMemoryXilinxHBirdMIGModuleImp extends LazyModuleImp
    with HasMemoryXilinxHBirdMIGBundle {
  val outer: HasMemoryXilinxHBirdMIG
  val ranges = AddressRange.fromSets(p(MemoryXilinxDDRKey).address)
  require (ranges.size == 1, "DDR range must be contiguous")
  val depth = ranges.head.size
  val xilinxhbirdmig = IO(new XilinxHBirdMIGIO(depth))

  xilinxhbirdmig <> outer.xilinxhbirdmig.module.io.port
}
