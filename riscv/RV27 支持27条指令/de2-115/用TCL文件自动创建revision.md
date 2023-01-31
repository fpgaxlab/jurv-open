用TCL文件自动创建工程可以避免版本不兼容的问题，效率也很高。步骤如下。

  1. 启动 Quartus Prime，点击 View ➤ Tcl Console 菜单项打开 “Tcl Console” 子窗口。
  2. 打开RV_Project工程。
  3. 点击 Tools ➤ Tcl Scripts 菜单项，在弹出的窗口中选择 `create_revision_rv_DE2115.tcl`；点击“Run”按钮执行该脚本文件，之后会弹出一个信息框提示“Tcl Script File ... executed”。 但是，这并不代表执行成功了，如果出错，会在 “Tcl Console” 子窗口显示红色的错误信息，这也是步骤1要打开“Tcl Console” 子窗口的原因。
     > 注：该 TCL 脚本文件创建的Revision适用于DE2-115开发板。因为DE2-115引脚较多，脚本执行会花比较长时间。
     >
     > 也可以不用Tools ➤ Tcl Scripts 菜单项，在“Tcl Console” 子窗口最后一行输入 TCL 命令 `source ./create_revision_rv_DE2115.tcl` 。
