#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2015 Yann Sionneau <yann.sionneau@gmail.com>
# Copyright (c) 2015-2019 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from litex.build.generic_platform import *
from litex.build.xilinx import Xilinx7SeriesPlatform
from litex.build.openocd import OpenOCD

# IOs ----------------------------------------------------------------------------------------------

_io = [
    # Clk / Rst
    ("clk100",    0, Pins("R4"), IOStandard("LVCMOS33")),
    ("cpu_reset", 0, Pins("U2"), IOStandard("LVCMOS33")),


    # Leds
    ("user_led", 0, Pins("R2"),  IOStandard("LVCMOS33")),
    ("user_led", 1, Pins("R3"),  IOStandard("LVCMOS33")),
    ("user_led", 2, Pins("V2"),  IOStandard("LVCMOS33")),
    ("user_led", 3, Pins("Y2"),  IOStandard("LVCMOS33")),

    # GPIO
    ("gpio0", 0, Pins("Y8"),  IOStandard("LVCMOS33")),
    ("gpio1", 0, Pins("AB8"),  IOStandard("LVCMOS33")),
	
    # Buttons
    ("user_btn", 0, Pins("T1"), IOStandard("LVCMOS33")),
    ("user_btn", 1, Pins("U1"), IOStandard("LVCMOS33")),
    ("user_btn", 2, Pins("W2"), IOStandard("LVCMOS33")),
    ("user_btn", 3, Pins("T3"), IOStandard("LVCMOS33")),
	
    # Serial
    ("serial", 0,
        Subsignal("tx", Pins("T6")),
        Subsignal("rx", Pins("U5")),
        IOStandard("LVCMOS33")
    ),

    # USB FIFO
    ("usb_clk", 0, Pins("Y4"), IOStandard("LVCMOS33")),
    ("usb_fifo", 0, 
        Subsignal("data",  Pins("AB5 AA4 AB3 AA3 AB2 AB1 AA1 Y1")),
        Subsignal("rxf_n", Pins("W1")),
        Subsignal("txe_n", Pins("AA5")),
        Subsignal("rd_n",  Pins("V4")),
        Subsignal("wr_n",  Pins("Y3")),
        Subsignal("siwua", Pins("V3")),
        Subsignal("oe_n",  Pins("U3")),
        Misc("SLEW=FAST"),
        Drive(8),
        IOStandard("LVCMOS33"),
    ),

    # I2C
    ("i2c", 0,
        Subsignal("scl", Pins("R6")),
        Subsignal("sda", Pins("T4")),
        IOStandard("LVCMOS33"),
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
	
    # DDR3 SDRAM
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
	
    # RGB TFT-LCD
    ("lcd", 0,
        Subsignal("rst",  	Pins("W7")),
        #Subsignal("bl",    	Pins("V7")),
        Subsignal("clk",   	Pins("Y9")),
        Subsignal("de",    	Pins("AB7")),
        Subsignal("hsync_n", 	Pins("V8")),
        Subsignal("vsync_n", 	Pins("U7")),
        Subsignal("b",    	Pins("R16 P15 R14 P14 N14 N13 V9 W9")),
        Subsignal("g",     	Pins("U18 U17 V19 T18 V20 R18 N17 P17 ")),
        Subsignal("r",     	Pins("AB18 AA18 Y19 Y18 W20 W17 V18 V17")),
        IOStandard("LVCMOS33")
    ),
	
    # RGMII Ethernet
    ("eth_clocks", 0,
        Subsignal("tx", Pins("AA21")),
        Subsignal("rx", Pins("W19")),
        IOStandard("LVCMOS33")
    ),
    ("eth", 0,
        Subsignal("rst_n",   Pins("T21")),
        Subsignal("mdio",    Pins("U21")),
        Subsignal("mdc",     Pins("U22")),
        Subsignal("rx_ctl",  Pins("Y21")),
        Subsignal("rx_data", Pins("Y22 W21 W22 V22")),
        Subsignal("tx_ctl",  Pins("AB22")),
        Subsignal("tx_data", Pins("AB21 AA20 AB20 AA19")),
        IOStandard("LVCMOS33")
    ),
]

# Connectors ---------------------------------------------------------------------------------------

_connectors = [
   ("J2", {
        1: "M13",   2: "K14",
        3: "R17",   4: "J16",
        5: "M17",   6: "P19",
        7: "M16",   8: "P20",
        9: "L15",   10: "M15",
        11: "J17",  12: "L14",
        13: "K18",  14: "K17",
        15: "H19",  16: "K19",
        17: "F20",  18: "J19",
        19: "K16",  20: "F19",
        21: "L20",  22: "L16",
        23: "T20",  24: "L19",
        25: "N19",  26: "U20",
        27: "M20",  28: "N18",
        29: "J21",  30: "N20",
        31: "G20",  32: "J20",
        33: "L18",  34: "M18",
        35: "F21",  36: "F18",
	37: "E17",  38: "D17",
        39: "N22",  40: "M22",
        41: "M21",  42: "L21",
        43: "K22",  44: "K21",
        45: "J22",  46: "H22",
        47: "G22",  48: "G21",
	49: "E19",  50: "D19",
    }),
]

def raw_j2():
    return [("J2", 0, Pins(" ".join([f"J3:{i+1:d}" for i in range(50)])), IOStandard("LVCMOS33"))]
	
# Platform -----------------------------------------------------------------------------------------

class Platform(Xilinx7SeriesPlatform):
    default_clk_name   = "clk100"
    default_clk_period = 1e9/100e6

    def __init__(self, variant="a7-35", toolchain="vivado"):
        device = {
            "a7-35":  "xc7a35tfgg484-2",
            "a7-100": "xc7a100tfgg484-2"
        }[variant]
        Xilinx7SeriesPlatform.__init__(self, device, _io, _connectors, toolchain=toolchain)
        self.toolchain.bitstream_commands = \
            ["set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]"]
        self.toolchain.additional_commands = \
            ["write_cfgmem -force -format bin -interface spix4 -size 16 "
             "-loadbit \"up 0x0 {build_name}.bit\" -file {build_name}.bin"]
        self.add_platform_command("set_property INTERNAL_VREF 0.75 [get_iobanks 35]")

    def create_programmer(self):
        bscan_spi = "bscan_spi_xc7a100t.bit" if "xc7a100t" in self.device else "bscan_spi_xc7a35t.bit"
        return OpenOCD("openocd_xc7_ft2232.cfg", bscan_spi)

    def do_finalize(self, fragment):
        Xilinx7SeriesPlatform.do_finalize(self, fragment)
        try:
            self.add_period_constraint(self.lookup_request("eth_clocks").rx, 1e9/125e6)
        except ConstraintError:
            pass

    def do_finalize(self, fragment):
        Xilinx7SeriesPlatform.do_finalize(self, fragment)
        self.add_period_constraint(self.lookup_request("clk100", loose=True), 1e9/100e6)
        self.add_period_constraint(self.lookup_request("eth_clocks:rx", loose=True), 1e9/125e6)
