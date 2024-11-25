
# Create Project

create_project -force -name hseda_xc7a35t -part xc7a35tftg256-1
set_msg_config -id {Common 17-55} -new_severity {Warning}

# Add project commands


# Add Sources

read_verilog {/home/lc/桌面/venv/litex/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v}
read_verilog {/home/lc/桌面/venv/litex/litex-boards/litex_boards/targets/build/hseda_xc7a35t/gateware/hseda_xc7a35t.v}

# Add EDIFs


# Add IPs


# Add constraints

read_xdc hseda_xc7a35t.xdc
set_property PROCESSING_ORDER EARLY [get_files hseda_xc7a35t.xdc]

# Add pre-synthesis commands


# Synthesis

synth_design -directive default -top hseda_xc7a35t -part xc7a35tftg256-1

# Synthesis report

report_timing_summary -file hseda_xc7a35t_timing_synth.rpt
report_utilization -hierarchical -file hseda_xc7a35t_utilization_hierarchical_synth.rpt
report_utilization -file hseda_xc7a35t_utilization_synth.rpt
write_checkpoint -force hseda_xc7a35t_synth.dcp

# Add pre-optimize commands


# Optimize design

opt_design -directive default

# Add pre-placement commands


# Placement

place_design -directive default

# Placement report

report_utilization -hierarchical -file hseda_xc7a35t_utilization_hierarchical_place.rpt
report_utilization -file hseda_xc7a35t_utilization_place.rpt
report_io -file hseda_xc7a35t_io.rpt
report_control_sets -verbose -file hseda_xc7a35t_control_sets.rpt
report_clock_utilization -file hseda_xc7a35t_clock_utilization.rpt
write_checkpoint -force hseda_xc7a35t_place.dcp

# Add pre-routing commands


# Routing

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force hseda_xc7a35t_route.dcp

# Routing report

report_timing_summary -no_header -no_detailed_paths
report_route_status -file hseda_xc7a35t_route_status.rpt
report_drc -file hseda_xc7a35t_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file hseda_xc7a35t_timing.rpt
report_power -file hseda_xc7a35t_power.rpt
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Bitstream generation

write_bitstream -force hseda_xc7a35t.bit 
write_cfgmem -force -format bin -interface spix4 -size 16 -loadbit "up 0x0 hseda_xc7a35t.bit" -file hseda_xc7a35t.bin

# End

quit