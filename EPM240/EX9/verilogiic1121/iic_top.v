`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:
// Design Name:    
// Module Name:    iic_top
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
module iic_top(
			clk,rst_n,
			sw1,sw2,
			scl,sda,
			sm_cs1_n,sm_cs2_n,sm_db
		);
		
input clk;		// 50MHz
input rst_n;	//复位信号，低有效
input sw1,sw2;	//按键1、2,(1按下执行写入操作，2按下执行读操作)
output scl;		// 24C02的时钟端口
inout sda;		// 24C02的数据端口

output sm_cs1_n,sm_cs2_n;	//数码管片选信号，低有效
output[6:0] sm_db;	//7段数码管（不包括小数点）


wire[7:0] dis_data;		//在数码管上显示的16进制数

iic_com		iic_com(
				.clk(clk),
				.rst_n(rst_n),
				.sw1(sw1),
				.sw2(sw2),
				.scl(scl),
				.sda(sda),
				.dis_data(dis_data)
				);

led_seg7	led_seg7(
				.clk(clk),
				.rst_n(rst_n),
				.dis_data(dis_data),
				.sm_cs1_n(sm_cs1_n),
				.sm_cs2_n(sm_cs2_n),
				.sm_db(sm_db)	
				);
	
		

endmodule		
