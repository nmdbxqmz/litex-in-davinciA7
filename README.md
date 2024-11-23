# litex-in-davinciA7
本仓库适用于Windows上有Vivado，仅使用Ubuntu虚拟机安装litex环境的情况

## litex环境安装：
官方参考文档：
>https://github.com/litex-hub/linux-on-litex-vexriscv/tree/69545456c5ccfbc88973107d64c1b7097c9f4c9b

### 安装python3环境：
* 安装python3
```
sudo apt install build-essential device-tree-compiler wget git python3-setuptools `
sudo apt install python3-full
```
* 在当前路径下创建一个python3虚拟环境venv（不用虚拟环境的话下面运行set_up.py可能会报错）
```
python3 -m venv venv
```
* 激活环境（下面的命令需要在venv文件夹的上一级打开终端）
``` 
source venv/bin/activate
```
* 安装需要的包
```
pip3 install meson
```

### 克隆git仓库：
* 首先在python3虚拟环境venv下创建一个文件夹，然后激活环境后用终端cd到该文件夹内
` git clone https://github.com/litex-hub/linux-on-litex-vexriscv.git`
* 下载litex_setup并运行
```
wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
chmod +x litex_setup.py
litex_setup.py --init --install
```
* 运行后再update一下，不然后面运行make时可能会报错
```
litex_setup.py --update
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
* 


    

  
  


    



