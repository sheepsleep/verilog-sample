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
module modelsim_test(
				clk,rst_n,div
				);
	
input clk;		//系统时钟	
input rst_n;		//复位信号，低有效

output div;		//2分频信号

reg div;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) div <= 1'b0;
	else div <= ~div;
	

endmodule

