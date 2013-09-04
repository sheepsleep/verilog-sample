`timescale 1ns/1ns

//cyclone_PLL_top.v工程testbench
module tb_PLL();

//input
reg clk;
reg rst_n;

//output
wire led0,led1,led2;

//例化待仿真工程顶层文件
cyclone_PLL_top		u_PLL(
						.clk(clk),
						.rst_n(rst_n),
						.led0(led0),
						.led1(led1),
						.led2(led2)
					);


//reset signal generation
initial begin
	rst_n = 0;	//reset
	#100;
	rst_n = 1;	//reset over
	#1000;
	$stop;
end

//25MHz clock generation
initial begin
	clk = 0;
	forever
		#20 clk = ~clk;
end




endmodule


