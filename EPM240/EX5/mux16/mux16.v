`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    23:08:36 04/21/08
// Design Name:    
// Module Name:    mux_16bit
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
module mux16(
			clk,rst_n,
			start,ain,bin,yout,done
		);
		
input clk;		//芯片的时钟信号。
input rst_n;	//低电平复位、清零信号。定义为0表示芯片复位；定义为1表示复位信号无效。
input start; 	//芯片使能信号。定义为0表示信号无效；定义为1表示芯片读入输入管脚得乘数和被乘数，并将乘积复位清零。
input[15:0] ain;	//输入a（被乘数），其数据位宽为16bit.
input[15:0] bin;	//输入b（乘数），其数据位宽为16bit.
output[31:0] yout;	//乘积输出，其数据位宽为32bit.
output done;		//芯片输出标志信号。定义为1表示乘法运算完成.

reg[15:0] areg;	//乘数a寄存器
reg[15:0] breg;	//乘数b寄存器
reg[31:0] yout_r;	//乘积寄存器
reg done_r;
reg[4:0] i;		//移位次数寄存器


//------------------------------------------------
//数据位控制
always @(posedge clk or negedge rst_n)
	if(!rst_n) i <= 5'd0;
	else if(start && i < 5'd17) i <= i+1'b1; 
	else if(!start) i <= 5'd0;

//------------------------------------------------
//乘法运算完成标志信号产生
always @(posedge clk or negedge rst_n)
	if(!rst_n) done_r <= 1'b0;
	else if(i == 5'd16) done_r <= 1'b1;		//乘法运算完成标志
	else if(i == 5'd17) done_r <= 1'b0;		//标志位撤销

assign done = done_r;

//------------------------------------------------
//专用寄存器进行移位累加运算
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin 
			areg <= 16'h0000;
			breg <= 16'h0000;
			yout_r <= 32'h00000000;
		end
	else if(start) begin		//启动运算
			if(i == 5'd0) begin	//锁存乘数、被乘数
					areg <= ain;
					breg <= bin;
				end
			else if(i > 5'd0 && i < 5'd16) begin
					if(areg[i-1]) yout_r = {1'b0,yout[30:15]+breg,yout_r[14:1]};	//累加并移位
					else yout_r <= yout_r>>1;	//移位不累加
				end
			else if(i == 5'd16 && areg[15]) yout_r[31:16] <= yout_r[31:16]+breg;	//累加不移位
		end
end

assign yout = yout_r;

endmodule

