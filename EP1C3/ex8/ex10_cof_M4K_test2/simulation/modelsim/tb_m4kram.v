//testbench for vgasdram

`timescale 1ns/1ns


module tb_m4kram;

reg clk;		//系统时钟，50MHz
reg rst_n;		//复位信号，低电平有效

reg[3:0] shift_din;
wire[3:0] shift_dout;
//wire[31:0] shift_all_data;
	wire	[3:0]  taps0x;
	wire	[3:0]  taps1x;
	wire	[3:0]  taps2x;
	wire	[3:0]  taps3x;
	wire	[3:0]  taps4x;
	wire	[3:0]  taps5x;
	wire	[3:0]  taps6x;
	wire	[3:0]  taps7x;

mem_cof	mem_cof(
			.clk(clk),
			.rst_n(rst_n),
			.shift_din(shift_din),
			.shift_dout(shift_dout),
			//.shift_all_data(shift_all_data)
				.taps0x(taps0x),
				.taps1x(taps1x),
				.taps2x(taps2x),
				.taps3x(taps3x),
				.taps4x(taps4x),
				.taps5x(taps5x),
				.taps6x(taps6x),
				.taps7x(taps7x)
		);

integer i;
initial begin
	rst_n = 0;
	shift_din = 4'hz;
	#200;
	rst_n = 1;
	
	#3_000;	//delay 3us
	
	for(i=0;i<70;i=i+1) begin
		@(posedge clk);
		shift_din = {$random}>>18;
		end

	@(posedge clk);	

	@(posedge clk);

	@(posedge clk);

	
	#100;	
	$stop;	
end

initial begin
	clk = 0;
	forever
	#10 clk = ~clk;
end




endmodule

