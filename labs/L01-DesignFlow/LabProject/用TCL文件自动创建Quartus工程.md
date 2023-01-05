用TCL文件自动创建工程可以避免版本不兼容的问题，效率也很高。步骤如下。

  1. 启动 Quartus Prime，点击 View ➤ Tcl Console 菜单项打开 “Tcl Console” 子窗口，最后一行可以输入 TCL 命令。
  2. 用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/LabProject` 。注意，路径要用“/”而不是“\”。
  3. 输入命令 `source ./create_project_pocket.tcl` 。 如果出现Select Family对话框，选择Cyclone IV E。之后将根据 tcl 文件中的脚本命令自动创建工程并打开在Project Navigate子窗口。
     > 注：create_project_pocket.tcl 是用于远程实验板和口袋实验板的脚本文件，如果是DE2-115实验板，替换成 create_project_de2-115.tcl。
