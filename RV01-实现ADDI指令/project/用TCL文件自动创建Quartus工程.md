用TCL文件自动创建工程可以避免版本不兼容的问题，效率也很高。步骤如下。

  1. 启动 Quartus Prime，点击 View ➤ Tcl Console 菜单项打开 “Tcl Console” 子窗口，最后一行可以输入 TCL 命令。
  2. 用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/project` 。注意，路径要用“/”而不是“\”。
  3. 输入命令 `source ./create_project_rv_pocket.tcl` 。 如果出现Select Family对话框，选择Cyclone IV E。之后将根据 tcl 文件中的脚本命令自动创建工程并打开在Project Navigate子窗口。
     > 注：该 TCL 脚本文件创建的工程适用于远程实验板和口袋实验板。
     >
     > 文件夹内如果已有同名工程文件，可能会导致创建失败。

如果上述方法创建失败，可以试下另一种方法。
  1. 在Quartus的安装目录下（如`C:\intelFPGA_lite\20.1\quartus\bin64`）找到 tclsh.exe，双击执行这个程序。
  2. 用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/project` 。注意，路径要用“/”而不是“\”。
  3. 输入命令 `quartus_sh -t create_project_rv_pocket.tcl`。之后将根据 tcl 文件中的脚本命令自动创建工程，可以看到创建的 .qpf 等文件。启动 Quartus，打开该工程。
