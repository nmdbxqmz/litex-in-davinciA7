# 说明
* 本目录下的文件为正点原子达芬奇A7板卡的相关支持文件
* 此readme为进阶教程，建议先看快速入门，在快速入门中有讲过的内容在这个readme中会略讲，litex老玩家直接忽略这句话

## readme目录结构
* no_linux使用教程
* with_linux使用教程
* 官方仓库中需要经常浏览（对使用者较为重要）的文件
* platform初步解析
* target初步解析
* make.py初步解析（运行后能生成可以运行liunx的源文件）

## no_linux使用教程
* 将本仓库no_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库no_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
* 激活环境
* cd到官方仓库中targets文件夹里
* 输入以下指令即可开始生成源文件：
  ```
  python3 hseda_xc7a35t.py --with-sdcard --with-buttons --build
  ```
* 或直接在桌面上启动的终端中运行以下指令,与上面的两步等效：
  ```
  python3 venv/litex/litex-boards/litex_boards/tagets/hseda_xc7a35t.py --with-sdcard --with-video-framebuffer --build
  ```
* 生成的源文件一般会在venv/litex/build/davinci中，有时也可能在venv/litex/litex-boards/litex_boards/targets/build/davinci中
* 将build/davinci/gateware中的文件全部拷贝到你PFGA项目的rtl中,同时也要拷贝venv/litex/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v文件到rtl中
* 修改davinci.c和davinci.xdc如下图所示，因为lcd的bl引脚官方给的函数不支持，所以要手动添加并上拉：

  davinci.c修改如下，在模块声明中添加output wire lcd_bl：
  ![]()

  davinci.xdc修改如下，在xdc中添加lcd_bl的约束并上拉：
  ```
  set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports lcd_bl]
  set_property PULLUP true [get_ports lcd_bl]
  ```
  ![]()
  
* 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时可以看到lcd屏依次显示白、红、绿、蓝、黑的颜色
* 剩下步骤与快速入门一致，这里不过多赘述了

## with_linux使用教程
* 将本仓库with_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库with_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
* 修改linux-on-litex-vexriscv/make.py文件如图所示，添加：
  ```
  if "video_colorbars" in board.soc_capabilities:
    soc_kwargs.update(with_colorbars=True)
  ```
  ![]()
*修改linux-on-litex-vexriscv/boards.py文件如图所示，添加：
  ```
  class davinci(Board):
    def __init__(self):
        from litex_boards.targets import alientek_davinci
        Board.__init__(self, alientek_davinci.BaseSoC, soc_capabilities={
            # Communication
            "serial",
            #"ethernet",
            # Storage
            "sdcard",
            # GPIOs
            "leds",
            "switches",
            # Buses
            "i2c",
            # Video,
            #"framebuffer",
            #"video_terminal",
            "video_colorbars",
        })

  ```
  ![]()
* 或将本仓库no_linux中make.py和boards.py直接覆盖官方仓库中的make.py和boards.py，与上面的两步等效
* 激活环境
* cd到官方仓库中linux-on-litex-vexriscv文件夹里
* 输入以下指令即可开始生成源文件：
  ```
  python3 make.py --board=davinci
  ```
* 或直接在桌面上启动的终端中运行以下指令,与上面的两步等效：
  ```
  python3 venv/litex/linux-on-litex-vexriscv/make.py --board=davinci
  ```
* 生成的源文件一般会在linux-on-litex-vexriscv/build/davinci中
* 将build/davinci/gateware中的文件全部拷贝到你PFGA项目的rtl中,同时也要拷贝venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/Ram_1w_1rs_Generic.v文件
  和venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_ITs4DTs4_Ldw128_Ood_Hb1.v文件到rtl中
* 修改davinci.c和davinci.xdc如下图所示，因为lcd的bl引脚官方给的函数不支持，所以要手动添加并上拉：

  davinci.c修改如下，在模块声明中添加output wire lcd_bl：
  ![]()

  davinci.xdc修改如下，在xdc中添加lcd_bl的约束并上拉：
  ```
  set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports lcd_bl]
  set_property PULLUP true [get_ports lcd_bl]

  ```
  ![]()
  
* 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时可以看到lcd屏显示彩条
* 剩下步骤与快速入门一致，这里不过多赘述了
  
