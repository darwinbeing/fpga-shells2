## This file is a general .xdc for the hbirdkit
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal

set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_14 Sch=CLK100MHZ
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];

set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { CLK32768KHZ }]; #IO_L13P_T2_MRCC_14 Sch=CLK32768KHZ
create_clock -add -name sys_clk_pin -period 30517.58 -waveform {0 15258.79} [get_ports {CLK32768KHZ}];

create_clock -add -name JTCK        -period 100   -waveform {0 50} [get_ports {mcu_TCK}];

##LEDs

set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { led_0 }]; #IO_L12N_T1_MRCC_14 Sch=led_0
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { led_1 }]; #IO_L14N_T2_SRCC_14 Sch=led_1
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { led_2 }]; #IO_L13N_T2_MRCC_14 Sch=led_2

##Buttons

set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS15 } [get_ports { fpga_rst }]; #IO_L17N_T2_34 Sch=fpga_rst
set_property -dict { PACKAGE_PIN P20   IOSTANDARD LVCMOS33 } [get_ports { mcu_rst }]; #IO_0_14 Sch=mcu_rst
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { mcu_wakeup }]; #IO_25_14 Sch=mcu_wakeup

##GPIO

set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { gpio[31] }]; #IO_L16N_T2_A15_D31_14 Sch=gpio[31]
set_property -dict { PACKAGE_PIN AA18  IOSTANDARD LVCMOS33 } [get_ports { gpio[30] }]; #IO_L17P_T2_A14_D30_14 Sch=gpio[30]
set_property -dict { PACKAGE_PIN AB18  IOSTANDARD LVCMOS33 } [get_ports { gpio[29] }]; #IO_L17N_T2_A13_D29_14 Sch=gpio[29]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { gpio[28] }]; #IO_L18P_T2_A12_D28_14 Sch=gpio[28]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { gpio[27] }]; #IO_L18N_T2_A11_D27_14 Sch=gpio[27]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { gpio[26] }]; #IO_L19P_T3_A10_D26_14 Sch=gpio[26]
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { gpio[25] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=gpio[25]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { gpio[24] }]; #IO_L20P_T3_A08_D24_14 Sch=gpio[24]
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { gpio[23] }]; #IO_L11N_T1_SRCC_14 Sch=gpio[23]
set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { gpio[22] }]; #IO_L12N_T1_MRCC_14 Sch=gpio[22]
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { gpio[21] }]; #IO_L13N_T2_MRCC_14 Sch=gpio[21]
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { gpio[20] }]; #IO_L14P_T2_SRCC_14 Sch=gpio[20]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { gpio[19] }]; #IO_L14N_T2_SRCC_14 Sch=gpio[19]
set_property -dict { PACKAGE_PIN AA19  IOSTANDARD LVCMOS33 } [get_ports { gpio[18] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=gpio[18]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { gpio[17] }]; #IO_L24N_T3_A00_D16_14 Sch=gpio[17]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { gpio[16] }]; #IO_L24P_T3_A01_D17_14 Sch=gpio[16]
set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { gpio[15] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=gpio[15]
set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { gpio[14] }]; #IO_L4P_T0_D04_14 Sch=gpio[14]
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { gpio[13] }]; #IO_L4N_T0_D05_14 Sch=gpio[13]
set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { gpio[12] }]; #IO_L5P_T0_D06_14 Sch=gpio[12]
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { gpio[11] }]; #IO_L5N_T0_D07_14 Sch=gpio[11]
set_property -dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33 } [get_ports { gpio[10] }]; #IO_L23P_T3_A03_D19_14 Sch=gpio[10]
set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { gpio[9] }]; #IO_L6N_T0_D08_VREF_14 Sch=gpio[9]
set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { gpio[8] }]; #IO_L7P_T1_D09_14 Sch=gpio[8]
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { gpio[7] }]; #IO_L11P_T1_SRCC_14 Sch=gpio[7]
set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { gpio[6] }]; #IO_L10N_T1_D15_14 Sch=gpio[6]
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { gpio[5] }]; #IO_L10P_T1_D14_14 Sch=gpio[5]
set_property -dict { PACKAGE_PIN Y22   IOSTANDARD LVCMOS33 } [get_ports { gpio[4] }]; #IO_L9N_T1_DQS_D13_14 Sch=gpio[4]
set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 } [get_ports { gpio[3] }]; #IO_L9P_T1_DQS_14 Sch=gpio[3]
set_property -dict { PACKAGE_PIN AA21  IOSTANDARD LVCMOS33 } [get_ports { gpio[2] }]; #IO_L8N_T1_D12_14 Sch=gpio[2]
set_property -dict { PACKAGE_PIN AA20  IOSTANDARD LVCMOS33 } [get_ports { gpio[1] }]; #IO_L8P_T1_D11_14 Sch=gpio[1]
set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { gpio[0] }]; #IO_L7N_T1_D10_14 Sch=gpio[0]

##JTAG

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets mcu_TCK]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33  } [get_ports {mcu_TCK}]; #IO_L22P_T3_A05_D21_14 Sch=mcu_TCK
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33  } [get_ports {mcu_TMS}]; #IO_L21N_T3_DQS_A06_D22_14 Sch=mcu_TMS
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33  } [get_ports {mcu_TDI}]; #IO_L20N_T3_A07_D23_14 Sch=mcu_TDI
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33  } [get_ports {mcu_TDO}]; #IO_L21P_T3_DQS_14 Sch=mcu_TDO
#create_clock -add -name JTCK        -period 100   -waveform {0 50} [get_ports {mcu_TCK}];

##Pmod Header JD

set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { jd_6 }]; #IO_L11P_T1_SRCC_13 Sch=jd_6

##USB-UART Interface (FTDI FT2232H)

set_property -dict { PACKAGE_PIN R17  IOSTANDARD LVCMOS33  } [get_ports { uart_rxd_out }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN P16  IOSTANDARD LVCMOS33  } [get_ports { uart_txd_in }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

##MCU QSPI Flash(W25Q32FVSSIG)

set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33  IOB TRUE } [get_ports { qspi_sck }]; #IO_L16P_T2_13 Sch=qspi_sck
# create_clock -add -name qspi_sck_pin -period 20.00 -waveform {0 10}    [get_ports { qspi_sck }];
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33  IOB TRUE } [get_ports { qspi_cs }]; #IO_L16N_T2_13 Sch=qspi_cs
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_0 }]; #IO_L15N_T2_DQS_13 Sch=qspi_dq[0]
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_1 }]; #IO_L15P_T2_DQS_13 Sch=qspi_dq[1]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_2 }]; #IO_L17P_T2_13 Sch=qspi_dq[2]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_3 }]; #IO_L17N_T2_13 Sch=qspi_dq[3]

##FPGA QSPI Flash(N25Q128A13ESF40G)

# set_property -dict { PACKAGE_PIN L12   IOSTANDARD LVCMOS33  IOB TRUE } [get_ports { qspi_sck }]; #CCLK_0 Sch=qspi_sck
# create_clock -add -name qspi_sck_pin -period 20.00 -waveform {0 10}    [get_ports { qspi_sck }];
# set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33  IOB TRUE } [get_ports { qspi_cs }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
# set_property -dict { PACKAGE_PIN P22   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_0 }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq_0
# set_property -dict { PACKAGE_PIN R22   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_1 }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq_1
# set_property -dict { PACKAGE_PIN P21   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_2 }]; #IO_L2P_T0_D02_14 Sch=qspi_dq_2
# set_property -dict { PACKAGE_PIN R21   IOSTANDARD LVCMOS33  IOB TRUE  PULLUP TRUE } [get_ports { qspi_dq_3 }]; #IO_L2N_T0_D03_14 Sch=qspi_dq_3

##Power Measurements

set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33     } [get_ports { pmu_paden }]; #IO_L14P_T2_SRCC_13 Sch=pmu_paden[10]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33     } [get_ports { pmu_padrst }]; #IO_L14N_T2_SRCC_13 Sch=pmu_padrst[10]
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33     } [get_ports { mcu_wakeup }]; #IO_25_14 Sch=ad_p[10]


set_clock_groups -asynchronous \
  -group [list \
     [get_clocks -include_generated_clocks -of_objects [get_ports mcu_TCK]]] \
  -group [list \
     [get_clocks -of_objects [get_pins ip_mmcm/inst/mmcm_adv_inst/CLKOUT0]]] \
  -group [list \
     [get_clocks -of_objects [get_pins ip_mmcm/inst/mmcm_adv_inst/CLKOUT1]] \
     [get_clocks -of_objects [get_pins ip_mmcm/inst/mmcm_adv_inst/CLKOUT2]]]

# ERROR: [Place 30-574] Poor placement for routing between an IO pin and BUFG. If this sub optimal condition is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to demote this message to a WARNING. However, the use of this override is highly discouraged. These examples can be used directly in the .xdc file to override this clock rule.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IOBUF_6/O]
