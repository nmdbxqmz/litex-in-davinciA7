################################################################################
# IO constraints
################################################################################
# clk100:0
set_property LOC R4 [get_ports {clk100}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk100}]

# cpu_reset:0
set_property LOC U2 [get_ports {cpu_reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_reset}]

# serial:0.tx
set_property LOC T6 [get_ports {serial_tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {serial_tx}]

# serial:0.rx
set_property LOC U5 [get_ports {serial_rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {serial_rx}]

# ddram:0.a
set_property LOC P2 [get_ports {ddram_a[0]}]
set_property SLEW FAST [get_ports {ddram_a[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[0]}]

# ddram:0.a
set_property LOC K3 [get_ports {ddram_a[1]}]
set_property SLEW FAST [get_ports {ddram_a[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[1]}]

# ddram:0.a
set_property LOC N5 [get_ports {ddram_a[2]}]
set_property SLEW FAST [get_ports {ddram_a[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[2]}]

# ddram:0.a
set_property LOC M6 [get_ports {ddram_a[3]}]
set_property SLEW FAST [get_ports {ddram_a[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[3]}]

# ddram:0.a
set_property LOC M2 [get_ports {ddram_a[4]}]
set_property SLEW FAST [get_ports {ddram_a[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[4]}]

# ddram:0.a
set_property LOC N3 [get_ports {ddram_a[5]}]
set_property SLEW FAST [get_ports {ddram_a[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[5]}]

# ddram:0.a
set_property LOC M3 [get_ports {ddram_a[6]}]
set_property SLEW FAST [get_ports {ddram_a[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[6]}]

# ddram:0.a
set_property LOC N4 [get_ports {ddram_a[7]}]
set_property SLEW FAST [get_ports {ddram_a[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[7]}]

# ddram:0.a
set_property LOC L3 [get_ports {ddram_a[8]}]
set_property SLEW FAST [get_ports {ddram_a[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[8]}]

# ddram:0.a
set_property LOC P6 [get_ports {ddram_a[9]}]
set_property SLEW FAST [get_ports {ddram_a[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[9]}]

# ddram:0.a
set_property LOC L4 [get_ports {ddram_a[10]}]
set_property SLEW FAST [get_ports {ddram_a[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[10]}]

# ddram:0.a
set_property LOC J6 [get_ports {ddram_a[11]}]
set_property SLEW FAST [get_ports {ddram_a[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[11]}]

# ddram:0.a
set_property LOC L5 [get_ports {ddram_a[12]}]
set_property SLEW FAST [get_ports {ddram_a[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[12]}]

# ddram:0.a
set_property LOC K6 [get_ports {ddram_a[13]}]
set_property SLEW FAST [get_ports {ddram_a[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_a[13]}]

# ddram:0.ba
set_property LOC N2 [get_ports {ddram_ba[0]}]
set_property SLEW FAST [get_ports {ddram_ba[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_ba[0]}]

# ddram:0.ba
set_property LOC L1 [get_ports {ddram_ba[1]}]
set_property SLEW FAST [get_ports {ddram_ba[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_ba[1]}]

# ddram:0.ba
set_property LOC M5 [get_ports {ddram_ba[2]}]
set_property SLEW FAST [get_ports {ddram_ba[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_ba[2]}]

# ddram:0.ras_n
set_property LOC J4 [get_ports {ddram_ras_n}]
set_property SLEW FAST [get_ports {ddram_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_ras_n}]

# ddram:0.cas_n
set_property LOC R1 [get_ports {ddram_cas_n}]
set_property SLEW FAST [get_ports {ddram_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_cas_n}]

# ddram:0.we_n
set_property LOC M1 [get_ports {ddram_we_n}]
set_property SLEW FAST [get_ports {ddram_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_we_n}]

# ddram:0.cs_n
set_property LOC L6 [get_ports {ddram_cs_n}]
set_property SLEW FAST [get_ports {ddram_cs_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_cs_n}]

# ddram:0.dm
set_property LOC J1 [get_ports {ddram_dm[0]}]
set_property SLEW FAST [get_ports {ddram_dm[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dm[0]}]

# ddram:0.dm
set_property LOC E2 [get_ports {ddram_dm[1]}]
set_property SLEW FAST [get_ports {ddram_dm[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dm[1]}]

# ddram:0.dq
set_property LOC H4 [get_ports {ddram_dq[0]}]
set_property SLEW FAST [get_ports {ddram_dq[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[0]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[0]}]

# ddram:0.dq
set_property LOC G2 [get_ports {ddram_dq[1]}]
set_property SLEW FAST [get_ports {ddram_dq[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[1]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[1]}]

# ddram:0.dq
set_property LOC H2 [get_ports {ddram_dq[2]}]
set_property SLEW FAST [get_ports {ddram_dq[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[2]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[2]}]

# ddram:0.dq
set_property LOC K1 [get_ports {ddram_dq[3]}]
set_property SLEW FAST [get_ports {ddram_dq[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[3]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[3]}]

# ddram:0.dq
set_property LOC J5 [get_ports {ddram_dq[4]}]
set_property SLEW FAST [get_ports {ddram_dq[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[4]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[4]}]

# ddram:0.dq
set_property LOC H3 [get_ports {ddram_dq[5]}]
set_property SLEW FAST [get_ports {ddram_dq[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[5]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[5]}]

# ddram:0.dq
set_property LOC H5 [get_ports {ddram_dq[6]}]
set_property SLEW FAST [get_ports {ddram_dq[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[6]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[6]}]

# ddram:0.dq
set_property LOC G3 [get_ports {ddram_dq[7]}]
set_property SLEW FAST [get_ports {ddram_dq[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[7]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[7]}]

# ddram:0.dq
set_property LOC B2 [get_ports {ddram_dq[8]}]
set_property SLEW FAST [get_ports {ddram_dq[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[8]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[8]}]

# ddram:0.dq
set_property LOC F1 [get_ports {ddram_dq[9]}]
set_property SLEW FAST [get_ports {ddram_dq[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[9]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[9]}]

# ddram:0.dq
set_property LOC A1 [get_ports {ddram_dq[10]}]
set_property SLEW FAST [get_ports {ddram_dq[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[10]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[10]}]

# ddram:0.dq
set_property LOC D2 [get_ports {ddram_dq[11]}]
set_property SLEW FAST [get_ports {ddram_dq[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[11]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[11]}]

# ddram:0.dq
set_property LOC B1 [get_ports {ddram_dq[12]}]
set_property SLEW FAST [get_ports {ddram_dq[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[12]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[12]}]

# ddram:0.dq
set_property LOC G1 [get_ports {ddram_dq[13]}]
set_property SLEW FAST [get_ports {ddram_dq[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[13]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[13]}]

# ddram:0.dq
set_property LOC C2 [get_ports {ddram_dq[14]}]
set_property SLEW FAST [get_ports {ddram_dq[14]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[14]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[14]}]

# ddram:0.dq
set_property LOC F3 [get_ports {ddram_dq[15]}]
set_property SLEW FAST [get_ports {ddram_dq[15]}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_dq[15]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dq[15]}]

# ddram:0.dqs_p
set_property LOC K2 [get_ports {ddram_dqs_p[0]}]
set_property SLEW FAST [get_ports {ddram_dqs_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_dqs_p[0]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dqs_p[0]}]

# ddram:0.dqs_p
set_property LOC E1 [get_ports {ddram_dqs_p[1]}]
set_property SLEW FAST [get_ports {ddram_dqs_p[1]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_dqs_p[1]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dqs_p[1]}]

# ddram:0.dqs_n
set_property LOC J2 [get_ports {ddram_dqs_n[0]}]
set_property SLEW FAST [get_ports {ddram_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_dqs_n[0]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dqs_n[0]}]

# ddram:0.dqs_n
set_property LOC D1 [get_ports {ddram_dqs_n[1]}]
set_property SLEW FAST [get_ports {ddram_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_dqs_n[1]}]
set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddram_dqs_n[1]}]

# ddram:0.clk_p
set_property LOC P5 [get_ports {ddram_clk_p}]
set_property SLEW FAST [get_ports {ddram_clk_p}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_clk_p}]

# ddram:0.clk_n
set_property LOC P4 [get_ports {ddram_clk_n}]
set_property SLEW FAST [get_ports {ddram_clk_n}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddram_clk_n}]

# ddram:0.cke
set_property LOC K4 [get_ports {ddram_cke}]
set_property SLEW FAST [get_ports {ddram_cke}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_cke}]

# ddram:0.odt
set_property LOC P1 [get_ports {ddram_odt}]
set_property SLEW FAST [get_ports {ddram_odt}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_odt}]

# ddram:0.reset_n
set_property LOC F4 [get_ports {ddram_reset_n}]
set_property SLEW FAST [get_ports {ddram_reset_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddram_reset_n}]

# user_led:0
set_property LOC R2 [get_ports {user_led0}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_led0}]

# user_led:1
set_property LOC R3 [get_ports {user_led1}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_led1}]

# user_led:2
set_property LOC V2 [get_ports {user_led2}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_led2}]

# user_led:3
set_property LOC Y2 [get_ports {user_led3}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_led3}]

# lcd:0.rst
set_property LOC W7 [get_ports {lcd_rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_rst}]

# lcd:0.clk
set_property LOC Y9 [get_ports {lcd_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_clk}]

# lcd:0.de
set_property LOC AB7 [get_ports {lcd_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_de}]

set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports lcd_bl]
set_property PULLUP true [get_ports lcd_bl]

# lcd:0.hsync_n
set_property LOC V8 [get_ports {lcd_hsync_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_hsync_n}]

# lcd:0.vsync_n
set_property LOC U7 [get_ports {lcd_vsync_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_vsync_n}]

# lcd:0.b
set_property LOC R16 [get_ports {lcd_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[0]}]

# lcd:0.b
set_property LOC P15 [get_ports {lcd_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[1]}]

# lcd:0.b
set_property LOC R14 [get_ports {lcd_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[2]}]

# lcd:0.b
set_property LOC P14 [get_ports {lcd_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[3]}]

# lcd:0.b
set_property LOC N14 [get_ports {lcd_b[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[4]}]

# lcd:0.b
set_property LOC N13 [get_ports {lcd_b[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[5]}]

# lcd:0.b
set_property LOC V9 [get_ports {lcd_b[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[6]}]

# lcd:0.b
set_property LOC W9 [get_ports {lcd_b[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[7]}]

# lcd:0.g
set_property LOC U18 [get_ports {lcd_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[0]}]

# lcd:0.g
set_property LOC U17 [get_ports {lcd_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[1]}]

# lcd:0.g
set_property LOC V19 [get_ports {lcd_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[2]}]

# lcd:0.g
set_property LOC T18 [get_ports {lcd_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[3]}]

# lcd:0.g
set_property LOC V20 [get_ports {lcd_g[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[4]}]

# lcd:0.g
set_property LOC R18 [get_ports {lcd_g[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[5]}]

# lcd:0.g
set_property LOC N17 [get_ports {lcd_g[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[6]}]

# lcd:0.g
set_property LOC P17 [get_ports {lcd_g[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[7]}]

# lcd:0.r
set_property LOC AB18 [get_ports {lcd_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[0]}]

# lcd:0.r
set_property LOC AA18 [get_ports {lcd_r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[1]}]

# lcd:0.r
set_property LOC Y19 [get_ports {lcd_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[2]}]

# lcd:0.r
set_property LOC Y18 [get_ports {lcd_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[3]}]

# lcd:0.r
set_property LOC W20 [get_ports {lcd_r[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[4]}]

# lcd:0.r
set_property LOC W17 [get_ports {lcd_r[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[5]}]

# lcd:0.r
set_property LOC V18 [get_ports {lcd_r[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[6]}]

# lcd:0.r
set_property LOC V17 [get_ports {lcd_r[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[7]}]

# sdcard:0.data
set_property LOC W6 [get_ports {sdcard_data[0]}]
set_property SLEW FAST [get_ports {sdcard_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[0]}]

# sdcard:0.data
set_property LOC Y6 [get_ports {sdcard_data[1]}]
set_property SLEW FAST [get_ports {sdcard_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[1]}]

# sdcard:0.data
set_property LOC U6 [get_ports {sdcard_data[2]}]
set_property SLEW FAST [get_ports {sdcard_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[2]}]

# sdcard:0.data
set_property LOC W4 [get_ports {sdcard_data[3]}]
set_property SLEW FAST [get_ports {sdcard_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[3]}]

# sdcard:0.cmd
set_property LOC W5 [get_ports {sdcard_cmd}]
set_property SLEW FAST [get_ports {sdcard_cmd}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_cmd}]

# sdcard:0.clk
set_property LOC V5 [get_ports {sdcard_clk}]
set_property SLEW FAST [get_ports {sdcard_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_clk}]

# sdcard:0.cd
set_property LOC AA6 [get_ports {sdcard_cd}]
set_property SLEW FAST [get_ports {sdcard_cd}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_cd}]

# user_sw:0
set_property LOC T1 [get_ports {user_sw0}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_sw0}]

# user_sw:1
set_property LOC U1 [get_ports {user_sw1}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_sw1}]

# user_sw:2
set_property LOC W2 [get_ports {user_sw2}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_sw2}]

# user_sw:3
set_property LOC T3 [get_ports {user_sw3}]
set_property IOSTANDARD LVCMOS33 [get_ports {user_sw3}]

# i2c:0.scl
set_property LOC R6 [get_ports {i2c0_scl}]
set_property IOSTANDARD LVCMOS33 [get_ports {i2c0_scl}]

# i2c:0.sda
set_property LOC T4 [get_ports {i2c0_sda}]
set_property IOSTANDARD LVCMOS33 [get_ports {i2c0_sda}]

################################################################################
# Design constraints
################################################################################

set_property INTERNAL_VREF 0.75 [get_iobanks 35]

################################################################################
# Clock constraints
################################################################################


create_clock -name clk100 -period 10.0 [get_ports clk100]

set_clock_groups -group [get_clocks -include_generated_clocks -of [get_nets sys_clk]] -group [get_clocks -include_generated_clocks -of [get_nets main_clkin]] -asynchronous

################################################################################
# False path constraints
################################################################################


set_false_path -quiet -through [get_nets -hierarchical -filter {mr_ff == TRUE}]

set_false_path -quiet -to [get_pins -filter {REF_PIN_NAME == PRE} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE || ars_ff2 == TRUE}]]

set_max_delay 2 -quiet -from [get_pins -filter {REF_PIN_NAME == C} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE}]] -to [get_pins -filter {REF_PIN_NAME == D} -of_objects [get_cells -hierarchical -filter {ars_ff2 == TRUE}]]