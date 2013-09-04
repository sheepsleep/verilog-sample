

`timescale 1ns/1ns
module tb_sramtest();

//input
reg clk;		// 50MHz
reg rst_n;	//低电平复位

//output
wire led;		// LED1
wire[14:0] sram_addr;	// SRAM地址总线
wire sram_wr_n;		// SRAM写选通

//inout
wire [7:0] sram_data;	// SRAM数据总线


sram_test	sram_test(
					.clk(clk),
					.rst_n(rst_n),
					.led(led),
					.sram_addr(sram_addr),
					.sram_wr_n(sram_wr_n),
					.sram_data(sram_data)
				);

initial begin
	rst_n = 0;
	#200; rst_n = 1;
end

initial begin
	clk = 0;
	forever 
		#10 clk = ~clk;
end




endmodule
