#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2024 Akio Lin <akioolin@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

from litex.build.generic_platform import *
from litex.build.xilinx import Xilinx7SeriesPlatform
from litex.build.openocd import OpenOCD

# IOs ----------------------------------------------------------------------------------------------

_io = [
   # Clk / Rst
    ("clk50",    0, Pins("R4"), IOStandard("LVCMOS33")),
    ("cpu_reset", 0, Pins("U2"), IOStandard("LVCMOS33")),


    # Leds
    ("user_led", 0, Pins("R2"),  IOStandard("LVCMOS33")),
    ("user_led", 1, Pins("R3"),  IOStandard("LVCMOS33")),
    ("user_led", 2, Pins("V2"),  IOStandard("LVCMOS33")),
    ("user_led", 3, Pins("Y2"),  IOStandard("LVCMOS33")),

    # Switches(Buttons)
    ("user_sw", 0, Pins("T1"), IOStandard("LVCMOS33")),
    ("user_sw", 1, Pins("U1"), IOStandard("LVCMOS33")),
    ("user_sw", 2, Pins("W2"), IOStandard("LVCMOS33")),
    ("user_sw", 3, Pins("T3"), IOStandard("LVCMOS33")),

   # Serial
    ("serial", 0,
        Subsignal("tx", Pins("T6")),
        Subsignal("rx", Pins("U5")),
        IOStandard("LVCMOS33")
    ),

   # SDCard
    ("sdcard", 0,
        Subsignal("data", Pins("W6 Y6 U6 W4"),),
        Subsignal("cmd",  Pins("W5"),),
        Subsignal("clk",  Pins("V5")),
        Subsignal("cd",   Pins("AA6")),
        Misc("SLEW=FAST"),
        IOStandard("LVCMOS33"),
    ),

    ## DDR3 SDRAM
    ("ddram", 0,
        Subsignal("a", Pins( "P2 K3 N5 M6 M2 N3 M3 N4 L3 P6 L4 J6 L5 K6"), IOStandard("SSTL15")),
        Subsignal("ba",    Pins("N2 L1 M5"), IOStandard("SSTL15")),
        Subsignal("ras_n", Pins("J4"), IOStandard("SSTL15")),
        Subsignal("cas_n", Pins("R1"), IOStandard("SSTL15")),
        Subsignal("we_n",  Pins("M1"), IOStandard("SSTL15")),
        Subsignal("cs_n",  Pins("L6"), IOStandard("SSTL15")),
        Subsignal("dm", Pins("J1 E2"), IOStandard("SSTL15")),
        Subsignal("dq", Pins("H4 G2 H2 K1 J5 H3 H5 G3 B2 F1 A1 D2 B1 G1 C2 F3"), 
			IOStandard("SSTL15"), Misc("IN_TERM=UNTUNED_SPLIT_40")),
        Subsignal("dqs_p", Pins("K2 E1"), IOStandard("DIFF_SSTL15"), Misc("IN_TERM=UNTUNED_SPLIT_40")),
        Subsignal("dqs_n", Pins("J2 D1"), IOStandard("DIFF_SSTL15"), Misc("IN_TERM=UNTUNED_SPLIT_40")),
        Subsignal("clk_p", Pins("P5"), IOStandard("DIFF_SSTL15")),
        Subsignal("clk_n", Pins("P4"), IOStandard("DIFF_SSTL15")),
        Subsignal("cke",   Pins("K4"), IOStandard("SSTL15")),
        Subsignal("odt",   Pins("P1"), IOStandard("SSTL15")),
        Subsignal("reset_n", Pins("F4"), IOStandard("SSTL15")),
		Misc("SLEW=FAST"),
    ),
]

# Platform -----------------------------------------------------------------------------------------

class Platform(Xilinx7SeriesPlatform):
    default_clk_name   = "clk50"
    default_clk_period = 1e9/50e6

    def __init__(self, toolchain="vivado", with_core_resources=True):
        device = "xc7a35tftg256-1"
        io = _io

        Xilinx7SeriesPlatform.__init__(self, device, io, toolchain=toolchain)

        self.toolchain.bitstream_commands = \
            ["set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]"]
        self.toolchain.additional_commands = \
            ["write_cfgmem -force -format bin -interface spix4 -size 16 "
            "-loadbit \"up 0x0 {build_name}.bit\" -file {build_name}.bin"]
        self.add_platform_command("set_property INTERNAL_VREF 0.750 [get_iobanks 35]")
        self.add_platform_command("set_property CFGBVS VCCO [current_design]")
        self.add_platform_command("set_property CONFIG_VOLTAGE 3.3 [current_design]")

    def create_programmer(self):
        bscan_spi = "bscan_spi_xc7a35t.bit"
        return OpenOCD("openocd_xc7_ft232.cfg", bscan_spi)

    def do_finalize(self, fragment):
        Xilinx7SeriesPlatform.do_finalize(self, fragment)
        self.add_period_constraint(self.lookup_request("clk50", loose=True), 1e9/50e6)
