`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchise.3
// Create Date	: 2009.04.20
// Design Name	: cyclone_PLL_top
// Module Name	: cyclone_PLL_top
// Project Name	: cyclone_PLL_top
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 配置PLL产生一个系统输入时钟2倍频，相移0度的时钟
//					
// Revision		: V1.0
// Additional Comments	:  
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module cyclone_PLL_top(
				clk,rst_n,
				clkdiv,locked
			);

input clk;		//25MHz系统外部输入时钟
input rst_n;	//系统复位信号，低电平有效

output clkdiv;	//PLL输出时钟
output locked;	//稳定PLL输出标志位，高有效

//PLL产生模块
//产生一个系统输入时钟2倍频，相移0度的时钟
PLL_ctrl	PLL_ctrl_inst (
				.areset(~rst_n),	//PLL异步复位信号,高有效
				.inclk0(clk),		//PLL输入时钟
				.c0(clkdiv),		//PLL输出时钟
				.locked(locked)		//稳定PLL输出标志位，高有效
			);


endmodule

