
set top tb_E300HBirdKitFPGAChip
set tbdir [file join [pwd] testbench]

# set number of threads to 8 (maximum, unfortunately)
set_param general.maxThreads 8

set_property target_language Verilog [current_project]
set_property default_lib work [current_project]

current_fileset

# set_property include_dirs ${wrkdir}/../../install/rtl/core/ [current_fileset]

set_property top $top [get_filesets sim_1]

launch_simulation

start_gui

# open_wave_config ${tbdir}/fpga_tb_top_behav.wcfg

run 10ms
