# litex-in-davinciA7
* 本仓库适用Windows上有Vivado，仅使用Ubuntu虚拟机安装litex环境的情况（用WSL或Ubuntu+Vivado的可以参考部分）
* 使用的FPGA板卡为正点原子的达芬奇A7

## 仓库目录结构说明
* QuickStart：快速入门，里面有写怎么简单构建源文件，并生成bit流将其烧入到板卡上
* advancement：进阶教程，里面含有达芬奇A7的相关支持文件和构建源文件、烧入板卡的教程，有对platform、target文件和源文件构建过程的简单解析
* prebuild：预构建文件，即QuickStart、advancement中执行构建源文件后生成的.v文件及其相关文件，环境安装失败、QuickStart、advancement执行构建操作失败的可以用这里面的来生成bit流
* software：QuickStart、advancement中执行构建源文件后生成的配套c语言库函数，可用由来编写对应板的程序，生成bin文件后可载入板卡中运行
* images：本仓库中所用到的图片
* 建议阅读顺序：litex环境安装->QuickStart->advancement->software

## litex环境安装：
* 官方参考文档：
>https://github.com/litex-hub/linux-on-litex-vexriscv/tree/69545456c5ccfbc88973107d64c1b7097c9f4c9b

* 视频参考：
>https://www.bilibili.com/video/BV1qd4y1V7y3/?spm_id_from=333.337.search-card.all.click&vd_source=a29c870e10911c3164efd99cf889c405

### 安装python3环境：
* 安装python3
    ```
    sudo apt install build-essential device-tree-compiler wget git python3-setuptools 
    sudo apt install python3-full
    ```
* 选择一个位置创建一个文件夹venv（也可以自己随便取一个），然后在该位置打开终端用下面的命令在venv文件夹里创建虚拟环境（不用虚拟环境的话运行.py文件可能会报错）
    ```
    python3 -m venv venv  //后面一个venv即为你取的文件夹名
    ```
* 激活环境（下面的命令需要在venv文件夹的上一级打开终端）
    ``` 
    source venv/bin/activate
    ```
    下图为在桌面这个位置创建文件夹venv并在该文件夹里创建虚拟环境，然后从桌面这个位置打开终端，激活环境后的示例：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/activate.png)
* 安装需要的包，激活虚拟环境然后执行以下指令：
    ```
    pip3 install meson
    ```
    
### 安装ninja软件
* 直接在任意位置打开终端执行以下指令即可：
    ```
    sudo apt install ninja
    ```

### 克隆git仓库：
* 首先在python3虚拟环境venv下创建一个文件夹litex（方便管理），然后cd到该文件夹内运行下面的指令
    ```
    git clone https://github.com/litex-hub/linux-on-litex-vexriscv.git
    ```
* 激活虚拟环境后再cd到litex文件夹内下载litex_setup.py并运行
    ```
    wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
    chmod +x litex_setup.py
    python3 litex_setup.py --init --install
    ```
    如果不使用虚拟环境去运行.py文件会可能会报错误，下图为运行python3 litex_setup.py --init --install时报的错误：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/litex_setup_error.png)

    想要了解一下报错信息的可以参考一下这篇CSDN文章：
    >https://blog.csdn.net/qq_25439417/article/details/139485697
* 运行后再update一下，不然后面运行make时可能会报错
    ```
    python3 litex_setup.py --update
    ```

### 安装gcc riscv 工具链
* 下载工具链，也可以在windows上从以下地址选择合适版本下载后移到虚拟机上（解压和添加路径命令中的“riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14”需要根据你实际下载的版本进行修改）
    >https://github.com/sifive/freedom-tools/releases
    ```
    wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
    ```
* 解压
    ```
    tar -xvf riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14.tar.gz
    ```
* 添加路径
    ```
    export PATH=$PATH:$PWD/riscv64-unknown-elf-gcc-8.1.0-2019.01.0-x86_64-linux-ubuntu14/bin/
    ```

### 安装SBT
用sdkman安装代码操作比较简单，但是下载速度比较慢，也可以去网上搜“liunx安装sbt”找其他方法安装sbt
* 安装sdkman
    ```
    curl -s "https://get.sdkman.io" | bash
    ```
* 有时候安装sdkman会失败，但是重新安装系统会告诉你已经存在了，不让安装，可以用下面指令删除sdkman再重新安装
    ```
    rm -rf ~/.sdkman
    ```
* 用sdkman安装jdk（很慢，大概半小时左右才能下完）
    ```
    sdk install java $(sdk list java | grep -o "\b8\.[0-9]*\.[0-9]*\-tem" | head -1)
    ```
* 用sdkman安装sbt（也很慢，大概半小时左右才能下完）
    ```
    sdk install sbt
    ```

### 安装verilator（仿真用）
参考文档：
>https://blog.csdn.net/2201_75757246/article/details/142878616

* 安装依赖软件
    ```
    sudo apt-get install git make autoconf g++ flex bison libz-dev
    ```
* 克隆verilator仓库
    ```
    sudo git clone http://git.veripool.org/git/verilator //或使用{git clone https://github.com/verilator/verilator}
    ```
* 执行以下操作(在verilator仓库所在目录的上一级打开终端)
    ```
    sudo chmod 777 -R verilator/
    unsetenv VERILATOR_ROOT //命令无效果时可忽略
    unset VERILATOR_ROOT
    cd verilator
    sudo git pull 
    sudo git checkout v4.216
    autoconf
    ./configure
    make
    sudo make install
    ```
* 验证是否安装成功，成功会显示版本号
    ```
    verilator --version
    ```

### 安装openocd
参考文档：
>https://blog.csdn.net/qq_40839071/article/details/114700646
* 安装依赖的软件
    ```
    sudo apt install libtool automake pkg-config libusb-1.0-0-dev libz-dev
    sudo apt-get install libtool automake libusb-1.0.0-dev texinfo libusb-dev libyaml-dev pkg-config
    ```
* 克隆openocd仓库
    ```
    sudo git clone https://github.com/SpinalHDL/openocd_riscv.git
    ```
* 执行以下操作（在openocd仓库所在目录的上一级打开终端）
    ```
    cd openocd_riscv/
    sudo git submodule update --init --recursive
    sudo chmod 777 -R ../openocd_riscv
    sudo ./bootstrap
    sudo apt-get install libhidapi*
    ./configure --enable-maintainer-mode --enable-usb_blaster_libftdi --enable-ftdi --enable-dummy
    make
    sudo make install
    ```
* 验证是否安装成功，成功会显示版本号
    ```
    openocd -v
    ```

### 测试环境
* 激活虚拟环境，然后cd到linux-on-litex-vexriscv这个目录里，运行make.py
    下图为在'桌面->venv->litex->liunx-on-litext-vexriscv->make.py'目录结构下执行上述操作的示例：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/make_example.png)
* 输出帮助信息，可以看看有哪些参数可以填
    ```
    python3 make.py -h
    ```
    下面为make.py的部分参数：
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/make_help.png)
* 生成arty这个板子的源文件（-build为生成bit流 -load为烧录，我们这些操作在window上运行，在使用上面已支持的Board时不填）
    ```
    python3 make.py --board=arty
    ```
* 如果环境安装成功，文件会生成在 linux-on-litex-vexriscv/buid/arty 目录里
下面为示例图片：
    ![]()
### 运行仿真
* 下载仿真所需要的镜像文件，以下为下载地址，下载其中的liunx_2022_03_23.zip这个文件
    >https://github.com/litex-hub/linux-on-litex-vexriscv/issues/164
* 将解压后镜像文件夹里的所有文件（boot.json,Image,opensbi.bin,rootfs.cpio,rv32.dtb）复制到‘linux-on-litex-vexriscv/images/’目录里
* 激活虚拟环境，再cd到linux-on-litex-vexriscv文件夹里，运行以下指令,会需要比较久的时间
    ```
    python3 sim.py
    ```
  






