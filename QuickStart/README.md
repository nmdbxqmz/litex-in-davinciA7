# 说明
* 一般来说，直接魔改官方给的litex_boards/platforms、litex_boards/targets文件夹中的.py文件最快，官方给了很多支持的板卡，大家可以选择和自己手上有的板卡最相似的板卡文件进行魔改，这里给的示例是魔改了官方的hseda_xc7a35t板卡（外设少，改起来快）
* 有2种生成方式，一种是在litex_boards/boards/里运行.py文件，生成的源文件是不支持跑liunx的，另一种是在linux-on-litex-vexriscv/里运行make.py，生成的源文件支持跑linux
  
## 本仓库示例中虚拟机所使用的目录结构
  ```
                                                  ->linux-on-litex-vexriscv->make.py
                                                 |
  桌面->venv(虚拟环境)->litex(克隆官方仓库的文件夹)--
                                                 |                              ->platforms->hseda_xc7a35t.py
                                                 |                             |
                                                  ->litex-boards->litex_boards-
                                                                               |
                                                                                ->targets->hseda_xc7a35t.py
  ```
  下图所示为环境安装完成后litex文件夹内的目录结构：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/litex_dir_stucture.png)

## litex_board_no_linux使用教程
* 将本仓库litex_board_no_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库litex_board_no_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
* 激活环境
* cd到官方仓库中targets文件夹里
* 输入以下指令即可开始生成源文件：
  ```
  python3 hseda_xc7a35t.py --with-sdcard --with-buttons --build
  ```
  不清楚后面参数的可以输入下面指令来查看帮助：
  ```
  python3 hseda_xc7a35t.py -h
  ```
  后面一定会报错以下错误，这是因为没有在虚拟机上装vivado导致的，忽略即可，因为已经生成了源文件，拿到window上用vivado操作即可
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/vivado_error.png)
* 生成的源文件一般会在venv/litex/build/HASEDA_xc7a35t中，有时也可能在venv/litex/litex-boards/litex_boards/targets/build/HASEDA_xc7a35t中，其中build是第一次运行时创建的，使用不同的target文件在build文件夹中生成出来的源文件名也不相同，本例使用hseda_xc7a35t.py则生成的源文件名为HASEDA_xc7a35t
  
  下图为生成在venv/litex/litex-boards/litex_boards/targets/build/HASEDA_xc7a35t中：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/build_dir.png)
* 将build/HASEDA_xc7a35t/gateware中的文件全部拷贝到你PFGA项目的rtl中（rtl为源代码文件，FPGA项目结构参考正点原子的，不清楚的可以看一下，如果下面的操作你清楚也可以按自己的风格来弄）
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/gateware.png)
* 同时也要拷贝venv/litex/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v文件到rtl中
  
  下图为tcl中命令，从中可以看出除了gateware中的hseda_xc7a35t.v，还要添加VexRiscv.v
   ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/add_addtional.png)
* 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时应该能看到板卡上在跑流水灯
* 随便用个串口助手（本例使用comtool的terminal），选择对应的串口，波特率为115200，打开串口，按下板卡上的reset可以看到以下内容：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/output_information.png)
* 使用terminal的话直接输指令然后按回车即可，如果只用收发模式每条指令下需要加换行再发送过去
  
  使用terminal示例：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/comtool_terminal.png)
  使用收发（send receive）模式示例：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/comtool_send_receive.png)
* 板卡上能运行的指令大家就自己摸索以一下把，不会很难
  
## litex_board_linux使用教程

### 生成源文件并生成bit流烧录至板卡
  * 将本仓库litex_board_linux中platform/hseda_xc7a35t.py覆盖掉官方仓库中platforms/hseda_xc7a35t.py，同理将本仓库litex_board_linux中targets/hseda_xc7a35t.py覆盖掉官方仓库中targets/hseda_xc7a35t.py
  * 修改litex_board_linux/boards.py文件，找到该文件中hseda_xc7a35t板卡的支持部分，修改为下（在参数部分加上switches）：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/boards_add_switches.png)
  * 激活环境
  * cd到官方仓库中linux-on-litex-vexriscv文件夹里
  * 输入以下指令即可开始生成源文件：
    ```
    python3 make.py --board=hseda_xc7a35t
    ```
    不清楚后面参数的可以输入下面指令来查看帮助：
    ```
    python3 make.py  -h
    ```
  * 生成的源文件一般会在venv/litex/linux-on-litex-vexriscv/build/HASEDA_xc7a35t中，其中build是第一次运行时创建的，使用不同的target文件在build文件夹中生成出来的源文件名也不相同，本例使用hseda_xc7a35t.py则生成的源文件名为HASEDA_xc7a35t
  * 将build/HASEDA_xc7a35t/gateware中的文件全部拷贝到你PFGA项目的rtl中（rtl为源代码文件，FPGA项目结构参考正点原子的，不清楚的可以看一下，如果下面的操作你清楚也可以按自己的风格来弄）
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/gateware.png)
  * 同时也要拷贝venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/Ram_1w_1rs_Generic.v文件和venv/litex/pythondata-cpu-vexriscv-smp/pythondata_cpu_vexriscv_smp/verilog/VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_ITs4DTs4_Ldw128_Ood_Hb1.v文件到rtl中
    
    下图为tcl中命令，从中可以看出除了gateware中的hseda_xc7a35t.v，还要添加Ram_1w_1rs_Generic.v、VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_ITs4DTs4_Ldw128_Ood_Hb1.v
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/add_addtional2.png)
  * 启动window中的vivado，将.v和.xdc全部添加进来，选择对应的板卡型号，生成bit流烧入进板卡，此时应该能看到板卡上在跑流水灯
  * 随便用个串口助手（本例使用comtool的terminal），选择对应的串口，波特率为115200，打开串口，按下板卡上的reset可以看到以下内容：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/output_information2.png)
  * 使用terminal的话直接输指令然后按回车即可，如果只用收发模式每条指令下需要加换行再发送过去
    
    使用terminal示例：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/comtool_terminal.png)
    使用收发（send receive）模式示例：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/comtool_send_receive.png)
  * 板卡上能运行的指令大家就自己摸索以一下把，不会很难

### 运行liunx
有2种方法，一种是通过虚拟机上的litex_term工具将镜像传进去，另一种是通过sd卡传进去
#### sd卡（推荐使用，更快）
  * 将以下地址中的liunx_2022_03_23.zip下载解压后内部的所有文件放到sd卡中
  
    >litex-hub/linux-on-litex-vexriscv#164
  * 将sd卡插入板卡中，按下reset即可，也可以通过sdcardboot指令
    
    下图为加载镜像时输出的内容：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/image_load.png)
    
#### litex_term
  * 虚拟机捕获window上连接了板卡的串口，此时在venv/litex/linux-on-litex-vexriscv/dev中应该有一个设备叫ttyUSB0（或者其他名字，以实际为准）

    如下图所示，在linux-on-litex-vexriscv目录下打开终端，输入`ls /dev/`指令，可以找到一个叫ttyUSB0的设备：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/ttyUSB0.png)
  * 激活虚拟环境，cd到venv/litex/linux-on-litex-vexriscv文件夹里，输入以下指令再按下reset就会开始通过串口传镜像了：
  ```
  sudo chmod 777 /dev/ttyUSB0
  litex_term /dev/ttyUSB1 --kernel=demo.bin
  ```
  下图为传输镜像时虚拟机cmd的输出：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/litex_term.png)

#### 下图为启动成功后的输出：
![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/linux_ok.png)


