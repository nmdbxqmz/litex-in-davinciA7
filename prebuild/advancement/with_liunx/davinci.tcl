
# Create Project

create_project -force -name davinci -part xc7a35tfgg484-2
set_msg_config -id {Common 17-55} -new_severity {Warning}

# Add project commands


# Add Sources

read_verilog {/home/lc/桌面/venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/Ram_1w_1rs_Generic.v}
read_verilog {/home/lc/桌面/venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_ITs4DTs4_Ldw128_Ood_Hb1.v}
read_verilog {/home/lc/桌面/venv/litex/linux-on-litex-vexriscv/build/davinci/gateware/davinci.v}

# Add EDIFs


# Add IPs


# Add constraints

read_xdc davinci.xdc
set_property PROCESSING_ORDER EARLY [get_files davinci.xdc]

# Add pre-synthesis commands


# Synthesis

synth_design -directive default -top davinci -part xc7a35tfgg484-2

# Synthesis report

report_timing_summary -file davinci_timing_synth.rpt
report_utilization -hierarchical -file davinci_utilization_hierarchical_synth.rpt
report_utilization -file davinci_utilization_synth.rpt
write_checkpoint -force davinci_synth.dcp

# Add pre-optimize commands


# Optimize design

opt_design -directive default

# Add pre-placement commands


# Placement

place_design -directive default

# Placement report

report_utilization -hierarchical -file davinci_utilization_hierarchical_place.rpt
report_utilization -file davinci_utilization_place.rpt
report_io -file davinci_io.rpt
report_control_sets -verbose -file davinci_control_sets.rpt
report_clock_utilization -file davinci_clock_utilization.rpt
write_checkpoint -force davinci_place.dcp

# Add pre-routing commands


# Routing

route_design -directive default
phys_opt_design -directive default
write_checkpoint -force davinci_route.dcp

# Routing report

report_timing_summary -no_header -no_detailed_paths
report_route_status -file davinci_route_status.rpt
report_drc -file davinci_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file davinci_timing.rpt
report_power -file davinci_power.rpt
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Bitstream generation

write_bitstream -force davinci.bit 
write_cfgmem -force -format bin -interface spix4 -size 16 -loadbit "up 0x0 davinci.bit" -file davinci.bin

# End

quit