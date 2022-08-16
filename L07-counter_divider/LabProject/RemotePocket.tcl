#------------------GLOBAL--------------------#
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE6E22C8
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF

set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY .\\output
set_global_assignment -name GENERATE_RBF_FILE ON
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name VERILOG_INPUT_VERSION SYSTEMVERILOG_2005

# 并行编译可使用的最大处理器数
set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL

#复位引脚  
# RESET按键
set_location_assignment PIN_110  -to RESET_N

#DEBIG IO
set_location_assignment PIN_125  -to JTCK
set_location_assignment PIN_127  -to JTMS
set_location_assignment PIN_120  -to JTDI
set_location_assignment PIN_119  -to JTDO

#时钟引脚 50M
set_location_assignment	PIN_88	-to CLOCK_50 


#LED对应的引脚
set_location_assignment	PIN_38	-to LEDR[0]
set_location_assignment	PIN_39	-to LEDR[1]
set_location_assignment	PIN_42	-to LEDR[2]
set_location_assignment	PIN_43	-to LEDR[3]
set_location_assignment	PIN_44	-to LEDR[4]
set_location_assignment	PIN_46	-to LEDR[5]
set_location_assignment	PIN_49	-to LEDR[6]
set_location_assignment	PIN_50	-to LEDR[7]
set_location_assignment	PIN_51	-to LEDR[8]
set_location_assignment	PIN_52	-to LEDR[9]
set_location_assignment	PIN_53	-to LEDR[10]
set_location_assignment	PIN_54	-to LEDR[11]
set_location_assignment	PIN_55	-to LEDR[12]
set_location_assignment	PIN_58	-to LEDR[13]
set_location_assignment	PIN_59	-to LEDR[14]
set_location_assignment	PIN_60	-to LEDR[15]

set_location_assignment	PIN_65	-to LEDG[0]
set_location_assignment	PIN_66	-to LEDG[1]
set_location_assignment	PIN_67	-to LEDG[2]
set_location_assignment	PIN_68	-to LEDG[3]
set_location_assignment	PIN_69	-to LEDG[4]
set_location_assignment	PIN_70	-to LEDG[5]
set_location_assignment	PIN_71	-to LEDG[6]
set_location_assignment	PIN_72	-to LEDG[7]

#按键对应的引脚
set_location_assignment	PIN_34	 -to KEY[0]
set_location_assignment	PIN_33	 -to KEY[1]
set_location_assignment	PIN_32   -to KEY[2]
set_location_assignment	PIN_31   -to KEY[3]

#开关对应的引脚
# set_location_assignment	PIN_30   -to SW[0]
# set_location_assignment	PIN_28   -to SW[1]
# set_location_assignment	PIN_11   -to SW[2]
# set_location_assignment	PIN_10   -to SW[3]
# set_location_assignment	PIN_7    -to SW[4]
# set_location_assignment	PIN_3    -to SW[5]
# set_location_assignment	PIN_2    -to SW[6]
# set_location_assignment	PIN_1    -to SW[7]

#数码管对应的引脚
#数码管7段+小数点
# set_location_assignment	PIN_98	-to SEG[0]
# set_location_assignment	PIN_99	-to SEG[1]
# set_location_assignment	PIN_100	-to SEG[2]
# set_location_assignment	PIN_101	-to SEG[3]
# set_location_assignment	PIN_103	-to SEG[4]
# set_location_assignment	PIN_104	-to SEG[5]
# set_location_assignment	PIN_105	-to SEG[6]
# set_location_assignment	PIN_106	-to SEG[7]

#8位数码管的8个控制位
# set_location_assignment	PIN_73	-to SEL[0]
# set_location_assignment	PIN_74	-to SEL[1]
# set_location_assignment	PIN_75  -to SEL[2]
# set_location_assignment	PIN_76	-to SEL[3]
# set_location_assignment	PIN_84	-to SEL[4] 
# set_location_assignment	PIN_85	-to SEL[5]
# set_location_assignment	PIN_86	-to SEL[6]
# set_location_assignment	PIN_87	-to SEL[7]

# 弱上拉
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to JTMS
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to JTDI
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to JTDO
