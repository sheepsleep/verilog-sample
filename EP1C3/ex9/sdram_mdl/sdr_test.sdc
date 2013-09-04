## Generated SDC file "sdr_test.sdc"

## Copyright (C) 1991-2008 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 8.1 Build 163 10/28/2008 SJ Full Version"

## DATE    "Thu May 14 18:17:47 2009"

##
## DEVICE  "EP1C3T144C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {SYS_25MCLK} -period 40.000 -waveform { 0.000 20.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

derive_pll_clocks -use_tan_name


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[0]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[0]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[10]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[10]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[11]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[11]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[12]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[12]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[13]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[13]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[14]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[14]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[15]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[15]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[1]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[1]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[2]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[2]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[3]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[3]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[4]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[4]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[5]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[5]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[6]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[6]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[7]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[7]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[8]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[8]}]
set_input_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  4.500 [get_ports {sdram_data[9]}]
set_input_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -2.000 [get_ports {sdram_data[9]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[0]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[0]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[10]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[10]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[11]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[11]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[1]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[1]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[2]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[2]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[3]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[3]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[4]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[4]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[5]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[5]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[6]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[6]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[7]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[7]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[8]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[8]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_addr[9]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_addr[9]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_ba[0]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_ba[0]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_ba[1]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_ba[1]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_cas_n}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_cas_n}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_cke}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_cke}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_cs_n}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_cs_n}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[0]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[0]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[10]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[10]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[11]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[11]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[12]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[12]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[13]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[13]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[14]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[14]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[15]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[15]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[1]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[1]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[2]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[2]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[3]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[3]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[4]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[4]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[5]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[5]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[6]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[6]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[7]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[7]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[8]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[8]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_data[9]}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_data[9]}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_ras_n}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_ras_n}]
set_output_delay -add_delay -max -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  1.500 [get_ports {sdram_we_n}]
set_output_delay -add_delay -min -clock [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -0.750 [get_ports {sdram_we_n}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {sdram_cke rst_n}] 


#**************************************************************
# Set Multicycle Path
#**************************************************************

set_multicycle_path -setup -end -from  [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_clk1}]  -to  [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}] 2
set_multicycle_path -setup -end -from  [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_extclk0}]  -to  [get_clocks {sys_ctrl:uut_sysctrl|PLL_ctrl:uut_PLL_ctrl|altpll:altpll_component|_clk1}] 2


#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

