用TCL文件自动创建工程可以避免版本不兼容的问题，步骤如下。
  1. 启动 Vivado ，在欢迎界面的下方找到 “Tcl Console” 窗口，最下方有一个编辑框可以输入 TCL 命令。
  2. 用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/LabPrj_Vivado` 。注意，路径要用“/”而不是“\”。
  3. 输入命令 `source ./create_project_n4ddr.tcl` 。 之后 Vivado 将根据 tcl 命令自动创建工程并进入工程管理界面。

注：该 TCL 文件创建的工程适用于 Nexys4DDR 开发板。