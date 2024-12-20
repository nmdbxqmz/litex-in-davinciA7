# 说明
* 本目录下的文件为正点原子达芬奇A7板卡的相关支持文件
* 此readme为进阶教程，建议先看快速入门，在快速入门中有讲过的内容在这个readme中会略讲，litex老玩家直接忽略这句话

## readme目录结构
* [no_linux使用教程](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#no_linux%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B)
* [with_linux使用教程](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#with_linux%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B)
* [官方仓库中需要经常浏览（对使用者较为重要）的文件](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#%E5%AE%98%E6%96%B9%E4%BB%93%E5%BA%93%E4%B8%AD%E9%9C%80%E8%A6%81%E7%BB%8F%E5%B8%B8%E6%B5%8F%E8%A7%88%E5%AF%B9%E4%BD%BF%E7%94%A8%E8%80%85%E8%BE%83%E4%B8%BA%E9%87%8D%E8%A6%81%E7%9A%84%E6%96%87%E4%BB%B6)
* [platform初步解析](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#platform%E5%88%9D%E6%AD%A5%E8%A7%A3%E6%9E%90)
* [target初步解析](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#target%E5%88%9D%E6%AD%A5%E8%A7%A3%E6%9E%90)
* [make.py初步解析](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/advancement#makepy%E5%88%9D%E6%AD%A5%E8%A7%A3%E6%9E%90)（运行后能生成可以运行liunx的源文件）

## no_linux使用教程
* 将本仓库no_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库no_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
* 激活环境
* cd到官方仓库中targets文件夹里
* 输入以下指令即可开始生成源文件：
  ```
  python3 alientek_davinci.py --with-sdcard --with-video-framebuffer --build
  ```
* 或直接在桌面上启动的终端中运行以下指令,与上面的两步等效：
  ```
  python3 venv/litex/litex-boards/litex_boards/tagets/alientek_davinci.py --with-sdcard --with-video-framebuffer --build
  ```
* 生成的源文件一般会在venv/litex/build/davinci中，有时也可能在venv/litex/litex-boards/litex_boards/targets/build/davinci中
* 将build/davinci/gateware中的文件全部拷贝到你PFGA项目的rtl中,同时也要拷贝venv/litex/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v文件到rtl中
* 注意：如下图所示，gateware其中的.init文件在.v文件中被读取，并被一起烧录到板卡上，每次更改配置后，生成的.init文件也会改变，所以每次更改配置并生成后，.init文件要用新生成的
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/init_read.png)
* 修改davinci.c和davinci.xdc如下图所示，因为lcd的bl引脚官方给的函数不支持，所以要手动添加并上拉（如果没有添加--with-video-framebuffer，即没有生成lcd外设，此步骤不用做）：

  davinci.c修改如下，在模块声明中添加output wire lcd_bl：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/.v_add.png)

  davinci.xdc修改如下，在xdc中添加lcd_bl的约束并上拉：
  ```
  set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports lcd_bl]
  set_property PULLUP true [get_ports lcd_bl]
  ```
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/xdc_add.png)
  
* 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时可以看到lcd屏依次显示白、红、绿、蓝、黑的颜色
* 剩下步骤与快速入门一致，这里不过多赘述了
* 还有一件事，不知道为什么当主频为100M时，波特率变成了57600（115200的一半），开串口助手时记得修改波特率为57600

## with_linux使用教程
* 将本仓库with_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库with_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
* 修改linux-on-litex-vexriscv/make.py文件如图所示，添加：
  ```
  if "video_colorbars" in board.soc_capabilities:
    soc_kwargs.update(with_colorbars=True)
  ```
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/make_change.png)
* 修改linux-on-litex-vexriscv/boards.py文件如图所示，添加一下语句，如果把"video_colorbars"注释掉，选择"framebuffer"或"video_terminal"则不需要修改linux-on-litex-vexriscv/make.py文件：
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
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/boards_change.png)
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
* 将build/davinci/gateware中的文件全部拷贝到你PFGA项目的rtl中，同时也要拷贝venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/Ram_1w_1rs_Generic.v文件
  和venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_ITs4DTs4_Ldw128_Ood_Hb1.v文件到rtl中
* 注意：如下图所示，gateware其中的.init文件在.v文件中被读取，并被一起烧录到板卡上，每次更改配置后，生成的.init文件也会改变，所以每次更改配置并生成后，.init文件要用新生成的
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/init_read.png)
* 修改davinci.c和davinci.xdc如下图所示，因为lcd的bl引脚官方给的函数不支持，所以要手动添加并上拉（如果注释了"video_colorbars"并且没有启用"framebuffer"和"video_terminal",，即没有生成lcd外设，此步骤不用做）：

  davinci.c修改如下，在模块声明中添加output wire lcd_bl：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/.v_add.png)

  davinci.xdc修改如下，在xdc中添加lcd_bl的约束并上拉：
  ```
  set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports lcd_bl]
  set_property PULLUP true [get_ports lcd_bl]

  ```
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/xdc_add.png)
  
* 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时可以看到lcd屏显示彩条（video_terminal为将板卡通过串口输出的信息同步显示到lcd上）
* 剩下步骤与快速入门一致，这里不过多赘述了
* 还有一件事，不知道为什么当主频为100M时，波特率变成了57600（115200的一半），开串口助手时记得修改波特率为57600
  
## 官方仓库中需要经常浏览（对使用者较为重要）的文件
* litex Wiki：有litex的初步介绍和很多链接仓库，可以跳转到与litex相关的其他仓库（比如下面两个）
  >https://github.com/enjoy-digital/litex/wiki
* litex cores：soc的外设文件，别人已经写好了外设生成文件，我们只需要调用他们给的函数即可（赞美面对对象的编程）
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/cores
* litex boards：有支持很多板卡的platform和target文件，不知道platform和target文件怎么写的可以在这里参考别人怎么写的
  >https://github.com/litex-hub/litex-boards
* litex software：c语言库函数，在虚拟机中生成源文件时会生成software，但是一部分文件变成了.o或.d文件看不了，所以写板上运行的程序时不知道函数怎么写时可以在里面找，其中的demo是给的示例，可以参考一下
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software

## platform初步解析
platform可以分为2个部分，一个是外设的io引脚声明，另一个就是Platform类的定义（在target中会被调用到）
### 外设io引脚声明
* 一般来说去添加和修改_io[...]里面这个部分即可，connectors这个部分不需要去修改
* 一般而言，只有一个io引脚的外设定义的为：
  ```
  (name,index,Pins(),IOStandard())
  ```
  有多个io引脚的外设定义的为：
  ```
  (name,index，Subsignal(name, Pins(),[IOStandard()],[Misc()]),Subsignal(name, Pins(),[IOStandard()],[Misc()])...,[IOStandard()],[Misc()])
  ```
  下图为io引脚声明的部分截图：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/io_example.png)
* 不会写的话就去官方给的platforms中找相似的，基本上改改Pins和IOStandard就可以用
### Platform类的定义
* 一般来讲，找到与自己板卡近似的platform文件后，里面的Platform类的定义可以不用修改

   下图为Platform类的定义的截图：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/platform().png)
* 一开始的两行为默认时钟名字和频率
* __init__()函数为platform类的初始化函数,如下图所示：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/__init__().png)
  其中调用的Xilinx7SeriesPlatform()函数定义如下：
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/build/xilinx/platform.py
  
  Xilinx7SeriesPlatform()函数中调用 GenericPlatform.__init__()函数，定义如下：
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/build/generic_platform.py
* create_programmer()函数与烧录、openocd调试有关，在如果指令中含有--load或--flash则在target文件中会被调用因为我们在Window上执行这些操作，所以可以不用管
  下图为create_programmer()在target中被调用的位置：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/creat_programer().png)
* do_finalize()，目前没有找到被调用的位置，暂时不知道是干什么用的

## target初步解析
target可以分为3个部分，分别为时钟域的定义，Soc的时钟、核、外设的定义，主函数读取参数并调用BaseSoC()和生成剩下的部分外设
### 时钟域的定义
* 一般来讲，找到与自己板卡近似的target后这个部分也不需要改什么，需要改的多参考一下官方给定target
  
  下图为时钟域定义的截图：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/CRG.png)
* __init__()传参作用：可以看到__init__()里面由许多参数，这是因为我们在调用该文件生成源文件时可以指定一部分的参数，比如之前使用的--with-video-framebuffer，这使with_video_framebuffer=True，从而生成Video所需要的时钟相关配置，而没有写上去的参数就会等于默认值（多为False），从而不被生成
* 时钟域的定义也可以分成两个部分，时钟域的定义和时钟管理
  
#### 时钟域的定义
这个是migen语法，不同的设备会用到不同的时钟域，一下为migen的链接：
  >https://m-labs.hk/gateware/migen/
#### 时钟管理
众所周知，vivado中的时钟管理由PLL和MMCM()，这个部分的编写可以参考其他target

### Soc的时钟、核、外设的定义
* 一般来讲，找到与自己板卡近似的target后这个部分会修改得比较多，要删除自己不需要的外设，添加自己要的外设（可以参考官方的target，很多都可以直接copy过来直接用）

  下图为Soc的时钟、核、外设的定义的截图：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/BaseSoc.png)
* __init__()传参作用：这里的与时钟域的定义中传参作用相同，生成被指定的外设，不生成没有被指定的外设
  
### 主函数读取参数并调用BaseSoC()和生成剩下的部分外设
* 一般来讲，找到与自己板卡近似的target后这个部分想要根据你改完后的Soc的时钟、核、外设的定义来调整
  
  以下为main()函数的截图：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/main.png)
* 第一段的传参调用了下面文件的add_target_argument和target_group.add_mutually_exclusive_group方法，add_target_argument可以从外部获取指令并给相应的标志位赋值，需要注意有些外设是冲突的，只能生成其中的一个，而add_mutually_exclusive_group就是用来处理这个的（一般我们输指令的时候也会注意这些冲突项，只生成其中的一个），add_target_argument里面的help后的字符串则是会在-h输出帮助中显示，如下图所示
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/parser.png)
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/build/parser.py
* 第二部分则是根据收到的参数生成Soc，其中时钟部分的参数传递路径为外部->main->BaseSoc->CRG
* 第三部分的Builder定义在以下文件中：
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/integration/builder.py
* 最后则是--build、--load --flash等参数发挥作用的地方，因为这个部分我们是在Window上操作的，所以用不到

## make.py初步解析
make.py的文件地址：
>https://github.com/litex-hub/linux-on-litex-vexriscv/blob/69545456c5ccfbc88973107d64c1b7097c9f4c9b/make.py

其中make.py最上面的截图如下所示，可以看到它从boards中读取支持的板卡：
![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/get_support_boards.png)

我们再看一下boards.py，如下图所示为是一般板子的书写格式，如果没有相应的board则会报错，这就是为什么在with_linux中需要手动往boards.py添加相应board的原因了，其中在Board.__init__中还有soc_capabilities这个参数，有什么用呢？我们再往下看

boards.py地址 >https://github.com/litex-hub/linux-on-litex-vexriscv/blob/69545456c5ccfbc88973107d64c1b7097c9f4c9b/boards.py

![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/boards_support.png)

下图为main函数开头的部分，读取指令中的参数：
![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/main_top.png)

往后看到peripheral就初见端倪了，原来Board.__init__中的soc_capabilities这个参数是被用在了这里，所以在使用make.py（with_linux）时，我们不能使用no_linux中--with--xx，而应该去boards.py中去修改对应板子定义里Board.__init__中的soc_capabilities，同时注意到没有video_colorbars这个参数，但是我需要用它来更新with_video_colorbars,所以这就是with_linux中需要添加上那些语句的原因了
![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/main_peripherals.png)

再后面看，可以看到如图所示的内容，部分参数会直接生成相应的外设，所以可以把target中相关外设的生成代码删除掉
![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/advancement/peripherals_direct.png)
