`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchise.3
// Create Date	: 2009.08.31
// Design Name	: johnson
// Module Name	: johnson
// Project Name	: johnson
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 该工程用于演示AS和JTAG下载方式
//					
// Revision		: V1.0
// Additional Comments	:  
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module johnson(
			clk,rst_n,
			led
		);

input clk;		//主时钟，25MHz
input rst_n;	//低电平复位
output led;		// LED接口

//------------------------------------
reg[24:0] delay;	//延时计数器

always @ (posedge clk or negedge rst_n)
	if(!rst_n) delay <= 25'd0;
	else delay <= delay+1'b1;	//不断计数，周期为1.34s

assign led = delay[24];		//1.34s LED闪烁一次

endmodule

