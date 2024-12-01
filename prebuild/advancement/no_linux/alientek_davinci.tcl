
# Create Project

create_project -force -name alientek_davinci -part xc7a35tfgg484-2
set_msg_config -id {Common 17-55} -new_severity {Warning}

# Add project commands


# Add Sources

read_verilog {/home/lc/桌面/venv/litex/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v}
read_verilog {/home/lc/桌面/venv/litex/litex-boards/litex_boards/targets/build/alientek_davinci/gateware/alientek_davinci.v}

# Add EDIFs


# Add IPs


# Add constraints

read_xdc alientek_davinci.xdc
set_property PROCESSING_ORDER EARLY [get_files alientek_davinci.xdc]

# Add pre-synthesis commands


# Synthesis

synth_design -directive default -top alientek_davinci -part xc7a35tfgg484-2

# Synthesis report

report_timing_summary -file alientek_davinci_timing_synth.rpt
report_utilization -hierarchical -file alientek_davinci_utilization_hierarchical_synth.rpt
report_utilization -file alientek_davinci_utilization_synth.rpt
write_checkpoint -force alientek_davinci_synth.dcp

# Add pre-optimize commands


# Optimize design

opt_design -directive default

# Add pre-placement commands


# Placement

place_design -directive default

# Placement report

report_utilization -hierarchical -file alientek_davinci_utilization_hierarchical_place.rpt
report_utilization -file alientek_davinci_utilization_place.rpt
report_io -file alientek_davinci_io.rpt
report_control_sets -verbose -file alientek_davinci_control_sets.rpt
report_clock_utilization -file alientek_davinci_clock_utilization.rpt
write_checkpoint -force alientek_davinci_place.dcp

# Add pre-routing commands


# Routing

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force alientek_davinci_route.dcp

# Routing report

report_timing_summary -no_header -no_detailed_paths
report_route_status -file alientek_davinci_route_status.rpt
report_drc -file alientek_davinci_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file alientek_davinci_timing.rpt
report_power -file alientek_davinci_power.rpt
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Bitstream generation

write_bitstream -force alientek_davinci.bit 
write_cfgmem -force -format bin -interface spix4 -size 16 -loadbit "up 0x0 alientek_davinci.bit" -file alientek_davinci.bin

# End

quit