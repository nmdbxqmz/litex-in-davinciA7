# 说明
* 在下面地址中给的是官方的demo例程,可以参照着写
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/demo
* 本目录下readme和demo都是以advancement/no_linux生成的software为例来写的
* 因为暂时没有学GCC和makefile的编写，所以只能在原demo的基础上微调，该目录中的demo移植了江协的OLED，可以显示字符串和播放动画

## 目录
* 几个重要的.h文件
* 如何添加自己的.c文件
* 如何生成Bin文件
* gpio的使用
* 中断的使用
* to be continue
  
## 几个重要的.h文件
* include/generated/csr.h
  如下图所示，里面有寄存器地址和配套外设的基础相关库函数
  ![]()
* libase/system.h
  因为编译后只剩下的.o.d文件，可以从以下地址查看.c文件
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase/system.c
  如下图所示，里面有系统相关的延时函数，也可以参考一下定时器中断怎么写
  ![]()
* libase/uart.h
  同样因为编译后只剩下的.o.d文件，可以从以下地址查看.c文件
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase/uart.c
  这个部分可以参考一下中断捕获怎么写
* libase/中的其他文件
  因为编译后libase/中只剩下的.o.d文件，不可查看，可以从以下地址查看相关的.c.h文件
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase
  如下图所示，这个文件中的.c文件是使用csr.h中基础库函数编写的高级库函数，需要进行相关外设控制但是不想写底层的可以到这里找高级库函数调用
  ![]()
  
## 如何添加自己的.c文件
* 目前我只会添加.c文件，.h文件暂时还不会添加
* 
## 如何生成Bin文件
* 在生成的源文件中有一个叫software的文件夹，里面的文件即为对应板卡的支持c语言库
* 我们需要将demo文件放到与build文件夹的同一目录下，并对makefile文件做如下更改：
  
  BUILD_DIR?=../build/的意义为demo/->进入到上一级（与build同级）->进入到build中，但是software在davinci中，所以build/后面再补上davinci即可
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/makefile_path.png)
* 如图所示，makefile中提到到了common.mak文件，但是software中没有，所以需要从以下地址中复制一份过去即可（本仓库中也有）
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software

  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/common_make.png)
* 进入到demo文件夹内，输入以下指令就会开始编译了(如果没有安装相关编译工具安装一下即可)：
  ```
  make
  ```
* 编译完成后demo中会出现一个demo.bin文件，将其放入sd卡中
* 最后将该仓库中的boot.json也添加进去，将sd卡插入板卡中运行即可
* 这里说明一下从sd卡中读取文件的原理，板卡上的程序运行时，如果插入了sd卡并且支持sd卡功能的话，上电就会读取boot.json这个文件，boot.json的内容如下图所示，
  它会指示Soc将左边的文件写入右边的地址中，并从最后一个地址开始运行，底下注释的部分即为载入linux时的boot.json的编写
  
    ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/boot_json.png)
* 说明一下，如果板卡上电没有读取到任何程序，那么就会运行默认程序bios.bin，在software中的bios文件夹中可以看到，可能是被写入到了rom.init文件中，烧录时被一起传进去了
