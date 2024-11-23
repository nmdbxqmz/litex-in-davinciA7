# 说明
## 这个文件夹是干什么的？
  * 该文件夹对应官方仓库的以下文件夹：
  >https://github.com/litex-hub/litex-boards/tree/master/litex_boards
  * 需要做的只有把platform文件夹中的alientek_davinci.py添加到虚拟机上对应的litex_boards->platforms文件夹中和把target文件夹中的alientek_davinci.py添加到虚拟机上对应的litex_boards->targets
  * 然后启动虚拟环境，cd到litex_boards->targets里，运行以下指令即可生成达芬奇A7的源文件：
    ```
    python3 alientek_davinci.py --build --with-sdcard  //--with-sdcard为可选参数
    ```
  * 也可以使用以下指令来输出帮助，查看有哪些参数可以写：
    ```
    python3 alientek_davinci.py -h
    ```
## platform是什么？
  * platform是
## target是什么？
  * target是
