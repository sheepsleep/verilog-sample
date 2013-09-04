`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:34:27 06/20/2012
// Design Name:   segled
// Module Name:   D:/segled/segled/segled_tb.v
// Project Name:  segled
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: segled
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module segled_tb;

	// Inputs
	reg osc_clk;
	reg sys_rst;

	// Outputs
	wire seg_mosi;
	wire seg_ncs;
	wire seg_sck;
	wire seg_c1;
	wire seg_c2;
	wire seg_c3;
	wire seg_c4;

	// Instantiate the Unit Under Test (UUT)
	segled uut (
		.osc_clk(osc_clk), 
		.sys_rst(sys_rst), 
		.seg_mosi(seg_mosi), 
		.seg_ncs(seg_ncs), 
		.seg_sck(seg_sck), 
		.seg_c1(seg_c1), 
		.seg_c2(seg_c2), 
		.seg_c3(seg_c3), 
		.seg_c4(seg_c4)
	);

	initial begin
		// Initialize Inputs
		osc_clk = 0;
		sys_rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

