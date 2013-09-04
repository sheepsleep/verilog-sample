`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:31:52 09/11/2008
// Design Name:   test_top
// Module Name:   vtf_test1.v
// Project Name:  top_dram
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module vtf_test;

reg clk;		//芯片的时钟信号。
reg rst_n;	//低电平复位、清零信号。定义为0表示芯片复位；定义为1表示复位信号无效。
reg start; 	//芯片使能信号。定义为0表示信号无效；定义为1表示芯片读入输入管脚得乘数和被乘数，并将乘积复位清零。
reg[15:0] ain;	//输入a（被乘数），其数据位宽为16bit.
reg[15:0] bin;	//输入b（乘数），其数据位宽为16bit.

wire[31:0] yout;	//乘积输出，其数据位宽为32bit.
wire done;		//芯片输出标志信号。定义为1表示乘法运算完成.

mux16	uut(
			.clk(clk),
			.rst_n(rst_n),
			.start(start),
			.ain(ain),
			.bin(bin),
			.yout(yout),
			.done(done)
		);

initial begin
	clk = 0;
	forever 
	#10 clk = ~clk;	//产生50MHz的时钟
end

initial begin
	rst_n = 1'b0;
	start = 1'b0;
	ain = 16'd0;
	bin = 16'd0;
	#1000;
	rst_n = 1'b1;	//上电后1us复位信号
	
	#1000;
	ain = 8'd89;
	bin = 8'd33;
	#100;
	start = 1'b1;
	#4500;
	start = 1'b0;
	#1000_000;
	$stop;
end
      
endmodule

