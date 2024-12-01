# 说明
* 在下面地址中给的是官方的demo例程,可以参照着写
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/demo
* 本目录下的demo是以advancement/no_linux中的相关配置文件生成的software为例来写的
* 因为暂时没有学GCC和makefile的编写，所以只能在原demo的基础上微调，该目录中的demo移植了江协的OLED，可以显示字符串和播放动画

## 目录
* [几个重要的.h文件](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/software#%E5%87%A0%E4%B8%AA%E9%87%8D%E8%A6%81%E7%9A%84h%E6%96%87%E4%BB%B6)
* [如何添加自己的.c文件](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/software#%E5%A6%82%E4%BD%95%E6%B7%BB%E5%8A%A0%E8%87%AA%E5%B7%B1%E7%9A%84c%E6%96%87%E4%BB%B6)
* [如何生成Bin文件](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/software#%E5%A6%82%E4%BD%95%E7%94%9F%E6%88%90bin%E6%96%87%E4%BB%B6)
* [gpio的使用](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/software#gpio%E7%9A%84%E4%BD%BF%E7%94%A8)
* [中断的使用](https://github.com/nmdbxqmz/litex-in-davinciA7/tree/master/software#%E4%B8%AD%E6%96%AD%E7%9A%84%E4%BD%BF%E7%94%A8)
* to be continue
  
## 几个重要的.h文件
* 在生成的源文件中有一个叫software的文件夹，里面的文件即为对应板卡的支持c语言库
* include/generated/csr.h
  如下图所示，里面有寄存器地址和配套外设的基础相关库函数
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/csr.png)
* ### libase/中的文件
  因为编译后libase/中只剩下的.o.d文件，不可查看，可以从以下地址查看相关的.c.h文件
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase
  
  如下图所示，这个文件中的.c文件是使用csr.h中基础库函数编写的高级库函数，需要进行相关外设控制但是不想写底层的可以到这里找高级库函数调用
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/libbase.png)
  #### libase/system.h
  .c文件的地址
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase/system.c
  
  如下图所示，里面有系统相关的延时函数，也可以参考一下定时器中断怎么写
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/system.png)
  #### libase/uart.h
  .c文件的地址
  >https://github.com/enjoy-digital/litex/blob/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software/libbase/uart.c
  
  这个部分可以参考一下中断捕获怎么写
  
## 如何添加自己的.c文件
* 目前只会添加.c文件，.h文件暂时还不会添加
* 首先添加头文件，像stdio等标准头文件正常引用即可，如果要引用software中的头文件，因为在makefile中已经写了头文件地址的路径为software/和software/include/，所以如果要引用的为 software/include/generated/csr.h则可以写`#include 'generated/csr.h'`，如果要引用的为software/libase/uart.h则可以写`#include <libbase/uart.h>`，如下图所示:
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/include.png)
  不会写的可以参考官方给的software中文件的头文件是怎么引入的
  >https://github.com/enjoy-digital/litex/tree/10dcc736767deb41bb172005631740bdd1fe6d9d/litex/soc/software
* 然后函数正常写即可，可能要注意的是在写一个函数前需要声明一下，如下图所示，不然编译的时候会警告，不过问题不大就是了，不想写的可以直接不写
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/ahead_statement.png)
* 接着如果其中的某个函数需要被其他文件引用，以main.c为例，需要在main.c中用extern来引入该函数，如下图所示：
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/extern.png)
* 最后，如下图所示：在makefile中'OBJECTS='这行加上你写的c文件的名称，文件后缀为.o，如本例的加的c文件叫oled.c，则此处加的为oled.o:
  ![](https://github.com/nmdbxqmz/litex-in-davinciA7/blob/master/images/software/OBJECT_ADD.png)

## 如何生成Bin文件
* 我们需要将demo文件放到与build文件夹的同一目录下，并对makefile文件做如下更改：
  
  BUILD_DIR?=../build/的意义为demo/->进入到上一级（与build同级）->进入到build中，但是software在alientek_davinci中，所以build/后面再补上alientek_davinci即可
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
## gpio的使用
## 中断的使用
