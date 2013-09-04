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

	// Inputs
	reg clk;
	reg rst_n;
	
	// Output
	wire div;

 modelsim_test		u1(
					.clk(clk),
					.rst_n(rst_n),
					.div(div)
					);

initial begin
	clk = 0;
	forever 
	#10 clk = ~clk;	//产生50MHz的时钟
end

initial begin
	rst_n = 0;
	#1000 rst_n = 1;	//上电后1us复位信号
	#1000;
	$stop;
end
      
endmodule

