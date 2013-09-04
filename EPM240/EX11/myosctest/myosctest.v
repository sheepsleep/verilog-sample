`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    
// Design Name:    
// Module Name:    
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module myosctest(
			rst_n,
			clkdiv
			);

input rst_n;	//低电平复位信号
output clkdiv;	//输出测试8分频信号

wire cscena = 1'b1;	//始终使能内部振荡器工作
wire clk;			//器件内部震荡时钟,3.3M~5.6M(仿真时钟5.56M)

internal_osc 	internal_osc(
						.oscena(cscena),
						.osc(clk)
					);

//8分频代码//
reg[2:0] cnt;

always @(posedge clk or negedge rst_n)
	if(!rst_n) cnt <= 3'd0;
	else cnt <= cnt+1'b1;
assign clkdiv = cnt[2];

endmodule


