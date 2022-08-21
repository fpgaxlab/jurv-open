# openJURV

### 介绍
RISC-V CPU 实验资源。授课视频及实验指导见中国大学慕课开放课程《计算机组成与CPU设计实验》（江苏大学 肖铁军），实验环境使用[FPGA实验云平台](http://welab.ujs.edu.cn/new/)。

### 文件组织结构
实验资源可以分为三大版块
  - 硬件描述语言和数字逻辑电路实验
  - 计算机组成原理实验
  - RISC-V CPU设计实验 

每一版块所对应的文件夹如下。

| 版块 |文件夹|
|:----:|:----:|
|实验环境| L00~L02 |
|硬件描述语言| L03~L08 |
|计算机组成原理实验| L09~L15 | 
|RISC-V CPU设计实验| 见下表  |

| 文件夹 | 描述 | 新增指令数 | 支持的指令数 |
| :----|:----|:----:|:----:|
|RV-00|工程框架| 
|RV-01|范例：addi指令| 1 | 1|
|RV-15|整数运算指令|  14| 15|
|RV-17|访存指令| 2 | 17 |
|RV-17IO|
|RV-23|分支指令| 6 | 23 |
|RV-27|LUI，AUIPC，JAL，JALR | 4 | 27 |
|RV-37|访存6条，SLT 4条| 10 | 37 | 


### 关于实验环境
支持团队致力于提供跨平台的软硬件实验环境。这里的“跨平台”有两方面含义，一是实验软件同时支持线上和线下方式，二是实验硬件同时支持两大主流FPGA厂商的芯片。

线上实验基于FPGA实验云，提供以云端真实实验板为基础的虚拟实验环境。线下实验基于Windows版的实验软件，通过USB适配器与多种实验板、开发板连接。

云端实验板的FPGA芯片采用的是Intel / Altera 芯片，实验平台支持线下 Quartus 编译上传电路文件，同时也提供了**云端编译**，支持平台无关的硬件设计。

线下实验通过特制的USB调试适配器可以适配 Intel/Altera 和 AMD/Xilinx 两大主流FPGA厂商的芯片和开发板，并且实验软件与线上环境有着相似的操作方式。所有实验项目中的范例充分考虑了可移植性，无需修改均可在 Quartus 和 Vivado 两种设计环境下编译通过。

跨平台的软硬件实验环境为实验教学提供了灵活的实施方式。既可以以线上方式为主，也可以以线下为主，还可以采用线上、线下混合的方式，比如线下实验室使用Altera 或 Xilinx 的开发板，线上完成慕课的预习和实验云平台的实验任务。


### 实验项目列表

 - L01-熟悉设计工具
 - L02-认识虚拟实验
 - L03-三态门和多路器
 - L04-七段译码器
 - L05-寄存器组(堆)
 - L06-流水灯与移位寄存器
 - L07-计数器和分频器
 - L08-彩灯控制器
 - L09-存储器
 - L10-汇编语言
 - L11-加减运算电路
 - L12-算术逻辑单元
 - L13-数据通路
 - L14-控制器
 - L15-RISC-V微架构

 - RV01-实现ADDI指令
 - RV02-实现运算指令
 - RV03-实现访存指令
 - RV04-实现分支指令
 - RV05-流水线初步实现
 - RV06-扩展数据通路
 - RV07-解决流水线冲突 
 - （待续...）



### 学习建议

- 硬件描述语言

    如果已经有Verilog/SystemVerilog（以下简称Verilog）基础，这部分可以快速浏览跳过。如果没有Verilog基础但已经熟练掌握VHDL，本课程的所有实验也都可以用VHDL完成，“01 熟悉设计工具”的“FPGA设计流程实验”中也给出了VHDL的代码模板；但是后面所有实验的范例只有Verilog的代码，实验指导和视频讲解也只是针对Verilog。

- 计算机组成原理实验

    这部分的实验内容和后面CPU设计实验内容有一部分交叉，“数据通路实验”、“硬布线控制器实验”和“RISC-V微架构实验”可以不做。对于偏软的专业，如果不做后面的RISC-V CPU设计实验，可以选择这几个实验作为初步的CPU设计，也可以选择CPU实验部分的开头两个实验。

    另外，不像其他实验项目之间有前后的依赖关系，“RISC-V汇编语言实验”和“存储器实验”这两个项目相对独立，顺序可以在这部分中前后调整。

- RISC-V CPU设计实验

    这部分实验又可以分为三个层次。

  - 基本层次。完成23条指令的单周期 RISC-V 以及初步的流水线设计。这23条指令分3个项目完成：整数运算指令、存储器访问指令和分支指令，每个项目的指导都给出了具体的数据通路。所谓“初步的流水线设计”，是指硬件不处理相关和冲突的流水线。
  - 常规层次。这个层次完成27条指令的单周期 RISC-V 以及流水线设计。虽然只增加了4条指令，但需要更复杂的数据通路。通过基本层次的训练，已经很好地理解了指令和数据通路的关系，所以这个层次需要学员自己设计数据通路。而流水线的设计，也需要用硬件处理数据冲突和控制冲突。
  - 提高层次。如果学有余力，可以在以下几个方面扩展。
    - 实现中断接口（基本层次中包含了简单输入输出接口）；
    - 实现分支预测；
    - 支持37条指令；
    - ......
