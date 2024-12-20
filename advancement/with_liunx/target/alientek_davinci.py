#!/usr/bin/env python3

#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2015-2019 Florent Kermarrec <florent@enjoy-digital.fr>
# Copyright (c) 2020 Antmicro <www.antmicro.com>
# Copyright (c) 2022 Victor Suarez Rovere <suarezvictor@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

# Note: For now with --toolchain=yosys+nextpnr:
# - DDR3 should be disabled: ex --integrated-main-ram-size=8192
# - Clk Freq should be lowered: ex --sys-clk-freq=50e6

from migen import *

from litex.gen import *

from litex_boards.platforms import alientek_davinci

from litex.soc.cores.clock import *
from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.cores.led import LedChaser
from litex.soc.cores.gpio import GPIOIn, GPIOTristate

from litedram.modules import MT41K128M16
from litedram.phy import s7ddrphy

from liteeth.phy.s7rgmii import LiteEthPHYRGMII
from litex.soc.cores.video import *

# CRG ----------------------------------------------------------------------------------------------

class _CRG(LiteXModule):
    def __init__(self, platform, sys_clk_freq, with_dram=True, with_rst=True, with_ethernet=False, with_etherbone=False,
                 with_video_terminal=False, with_video_framebuffer=False, with_video_colorbars=False):
        self.rst    = Signal()
        self.cd_sys = ClockDomain()
        if with_dram:
            self.cd_sys4x     = ClockDomain()
            self.cd_sys4x_dqs = ClockDomain()
            self.cd_idelay    = ClockDomain()
        if with_ethernet or with_etherbone:
            self.cd_eth = ClockDomain()
        if with_video_terminal or with_video_framebuffer or with_video_colorbars:
            self.cd_dvi = ClockDomain()
			
        # # #
        # Clk/Rst.
        clk100 = platform.request("clk100")
        rst    = ~platform.request("cpu_reset") if with_rst else 0

        # PLL.
        self.pll = pll = S7PLL(speedgrade=-1)
        self.comb += pll.reset.eq(rst | self.rst)
        pll.register_clkin(clk100, 100e6)
        pll.create_clkout(self.cd_sys, sys_clk_freq)
        if with_dram:
            pll.create_clkout(self.cd_sys4x,     4*sys_clk_freq)
            pll.create_clkout(self.cd_sys4x_dqs, 4*sys_clk_freq, phase=90)
            pll.create_clkout(self.cd_idelay,    200e6)
        if with_ethernet or with_etherbone:
            pll.create_clkout(self.cd_eth, 25e6)
        if with_video_terminal or with_video_framebuffer or with_video_colorbars:
            pll.create_clkout(self.cd_dvi,   33.3e6)
        platform.add_false_path_constraints(self.cd_sys.clk, pll.clkin)
        # IdelayCtrl.
        if with_dram:
            self.idelayctrl = S7IDELAYCTRL(self.cd_idelay)

# BaseSoC ------------------------------------------------------------------------------------------

class BaseSoC(SoCCore):
    def __init__(self, variant="a7-35", toolchain="vivado", sys_clk_freq=100e6,
        with_led_chaser = True,
	with_ethernet   = False,
        with_etherbone  = False,
        eth_ip          = "192.168.1.50",
        remote_ip       = None,
        eth_dynamic_ip  = False,
        with_gpio       = False,
	with_video_framebuffer = False,
        with_video_terminal    = False,
	with_video_colorbars = False,
        **kwargs):
        platform = alientek_davinci.Platform(variant=variant, toolchain=toolchain)

        # CRG --------------------------------------------------------------------------------------
        with_dram = (kwargs.get("integrated_main_ram_size", 0) == 0)
        self.crg  = _CRG(platform, sys_clk_freq, with_dram, with_rst=True, with_ethernet=with_ethernet, with_etherbone=with_etherbone,
                         with_video_terminal=with_video_terminal, with_video_framebuffer=with_video_framebuffer, with_video_colorbars=with_video_colorbars)

        # SoCCore ----------------------------------------------------------------------------------
        SoCCore.__init__(self, platform, sys_clk_freq, ident="LiteX SoC on Alientek DaVinci", **kwargs)

        # DDR3 SDRAM -------------------------------------------------------------------------------
        if not self.integrated_main_ram_size:
            self.ddrphy = s7ddrphy.A7DDRPHY(platform.request("ddram"),
                memtype        = "DDR3",
                nphases        = 4,
                sys_clk_freq   = sys_clk_freq)
            self.add_sdram("sdram",
                phy           = self.ddrphy,
                module        = MT41K128M16(sys_clk_freq, "1:4"),
                l2_cache_size = kwargs.get("l2_size", 8192)
            )
       
        # Leds -------------------------------------------------------------------------------------
        if with_led_chaser:
            self.leds = LedChaser(
                pads         = platform.request_all("user_led"),
                sys_clk_freq = sys_clk_freq,
            )
		
        # GPIOs ------------------------------------------------------------------------------------
        if with_gpio:
            platform.add_extension(alientek_davinci.raw_j2())
            self.gpio = GPIOTristate(
                pads     = platform.request("J2"),
                with_irq = self.irq.enabled
            )

        # LCD ------------------------------------------------------------------------------------
        video_timings = ("800x480@60Hz", {
            "pix_clk"       : 33.3e6,
            "h_active"      : 800,
            "h_blanking"    : 256,
            "h_sync_offset" : 210,
            "h_sync_width"  : 1,
            "v_active"      : 480,
            "v_blanking"    : 45,
            "v_sync_offset" : 22,
            "v_sync_width"  : 1,})
        if with_video_terminal or with_video_framebuffer or with_video_colorbars:
            self.videophy = VideoVGAPHY(platform.request("lcd"), clock_domain="dvi")
            if with_video_terminal:
                self.add_video_terminal(phy=self.videophy, timings=video_timings, clock_domain="dvi")
            elif with_video_framebuffer:
                self.add_video_framebuffer(phy=self.videophy, timings=video_timings, clock_domain="dvi")
            elif with_video_colorbars:
                self.add_video_colorbars(phy=self.videophy, timings=video_timings, clock_domain="dvi")

        # Ethernet ---------------------------------------------------------------------------------
        if with_ethernet or with_etherbone:
            self.ethphy = LiteEthPHYRGMII(
                    clock_pads = self.platform.request("eth_clocks"),
		    pads       = self.platform.request("eth"))
            if with_etherbone:
                self.add_etherbone(phy=self.ethphy, ip_address=eth_ip, with_ethmac=with_ethernet)
            elif with_ethernet:
                self.add_ethernet(phy=self.ethphy, dynamic_ip=eth_dynamic_ip, local_ip=eth_ip if not eth_dynamic_ip else None, remote_ip=remote_ip)

# Build --------------------------------------------------------------------------------------------

def main():
    from litex.build.parser import LiteXArgumentParser
    parser = LiteXArgumentParser(platform=alientek_davinci.Platform, description="LiteX SoC on Alientek DaVinci.")
    parser.add_target_argument("--variant",        default="a7-35",           help="Board variant (a7-35 or a7-100).")
    parser.add_target_argument("--sys-clk-freq",   default=100e6, type=float, help="System clock frequency.")
    parser.add_target_argument("--with-ethernet",  action="store_true",       help="Enable Ethernet support.")
    parser.add_target_argument("--with-etherbone", action="store_true",       help="Enable Etherbone support.")
    parser.add_target_argument("--eth-ip",         default="192.168.1.50",    help="Ethernet/Etherbone IP address.")
    parser.add_target_argument("--remote-ip",      default="192.168.1.100",   help="Remote IP address of TFTP server.")
    parser.add_target_argument("--eth-dynamic-ip", action="store_true",       help="Enable dynamic Ethernet IP addresses setting.")
    sdopts = parser.target_group.add_mutually_exclusive_group()
    sdopts.add_argument("--with-spi-sdcard",       action="store_true",       help="Enable SPI -mode SDCard support.")
    sdopts.add_argument("--with-sdcard",           action="store_true",       help="Enable SDCard support.")
    parser.add_target_argument("--with-gpio",      action="store_true",       help="Enable GPIOs through PMOD.") 
    viopts = parser.target_group.add_mutually_exclusive_group()
    viopts.add_argument("--with-video-terminal",    action="store_true", help="Enable Video Terminal (VGA).")
    viopts.add_argument("--with-video-framebuffer", action="store_true", help="Enable Video Framebuffer (VGA).")
    viopts.add_argument("--with-video-colorbars",   action="store_true", help="Enable Video Colorbars (VGA).")
    args = parser.parse_args()

    soc = BaseSoC(
        variant        = args.variant,
        toolchain      = args.toolchain,
        sys_clk_freq   = args.sys_clk_freq,
	with_ethernet  = args.with_ethernet,
        with_etherbone = args.with_etherbone,
        eth_ip         = args.eth_ip,
        remote_ip      = args.remote_ip,
        eth_dynamic_ip = args.eth_dynamic_ip,
        with_gpio      = args.with_gpio,
	with_video_terminal    = args.with_video_terminal,
        with_video_framebuffer = args.with_video_framebuffer,
	with_video_colorbars = args.with_video_colorbars,
        **parser.soc_argdict
    )

    if args.with_spi_sdcard:
        soc.add_spi_sdcard()
    elif args.with_sdcard:
        soc.add_sdcard()

    builder = Builder(soc, **parser.builder_argdict)
    if args.build:
        builder.build(**parser.toolchain_argdict)

    if args.load:
        prog = soc.platform.create_programmer()
        prog.load_bitstream(builder.get_bitstream_filename(mode="sram"))

    if args.flash:
        prog = soc.platform.create_programmer()
        prog.flash(0, builder.get_bitstream_filename(mode="flash"))

if __name__ == "__main__":
    main()
