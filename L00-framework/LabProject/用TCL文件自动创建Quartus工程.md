用TCL文件自动创建工程可以避免版本不兼容的问题，效率也很高。有两种方式。
### 方式1
  1. 启动 Windows 终端，用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/LabProject` 。  
  2. 确认 quartus_sh.exe 可用。输入命令 `quartus_sh`，如果显示帮助信息，说明可用，做下一步；如果报错，可能是Quartus的安装路径没有添加到PATH环境变量中，可以指定路径程序路径，如：`C:\intelFPGA_lite\20.1\quartus\bin64\quartus_sh`。
  3. 输入命令 `quartus_sh -t create_project_pocket.tcl`。其中 create_project_pocket.tcl 是用于远程实验板和口袋实验板的脚本文件，如果是DE2-115实验板，替换成 create_project_de2-115.tcl。之后将根据 tcl 文件中的脚本命令自动创建工程，可以看到 Lab.qpf 等文件。启动 Quartus，打开 Lab.qpf 工程。

### 方式2
  1. 在Quartus的安装目录下（如`C:\intelFPGA_lite\20.1\quartus\bin64\`）找到 tclsh.exe，双击执行这个程序。
  2. 用 cd 命令切换到 tcl 文件所在的目录，如 `cd d:/LabProject` 。注意，路径要用“/”而不是“\”。
  3. 输入命令 `quartus_sh -t create_project_pocket.tcl`。其中 create_project_pocket.tcl 是用于远程实验板和口袋实验板的脚本文件，如果是DE2-115实验板，替换成 create_project_de2-115.tcl。之后将根据 tcl 文件中的脚本命令自动创建工程，可以看到 Lab.qpf 等文件。启动 Quartus，打开 Lab.qpf 工程。