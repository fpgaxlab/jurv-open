Quartus支持在同一个工程中创建多个“修订”（Revision），并且可以复制一个现有的Revision设置，在此基础上创建新的Revision。可以手动创建Revision，也可以用脚本自动创建Revision。下面介绍用TCL脚本创建Revision。

  1. 脚本文件 create_revision_rv_de2-115.tcl 用于自动创建用于DE2-115实验板的Revision，将该文件及 DE2-115.sdc 和 RV_DE2_115.v 复制到工程所在文件夹。

  2. 启动 Quartus Prime，打开RV_Project工程。
     > 注：该工程已有的Rivision名称应为RV_Pocket，否则需要修改脚本。

  3. 点击 View ➤ Tcl Console 菜单项打开 “Tcl Console” 子窗口。
   
  4. 在“tcl>”提示符后输入 TCL 命令 `source ./create_revision_rv_DE2115.tcl` ，回车执行该脚本。因为DE2-115设置较多，脚本执行会花比较长时间，等待执行完成之后会回到“tcl>”提示符；如果出错，会在 “Tcl Console” 窗口显示红色的错误信息。

  5. 创建完成后可以通过Quartus工具条上的Revision下拉列表选择的不同的实验板设置。
