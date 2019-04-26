# See LICENSE for license details.


# Reduce these failures down to warnings to allow bit file to be generated without LOC constaints being applied to pins
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Write a bitstream for the current design
write_bitstream -force [file join $wrkdir "${top}.bit"]

# Save the timing delays for cells in the design in SDF format
write_sdf -force [file join $wrkdir "${top}.sdf"]

# Export the current netlist in verilog format
write_verilog -mode timesim -force [file join ${wrkdir} "${top}.v"]
