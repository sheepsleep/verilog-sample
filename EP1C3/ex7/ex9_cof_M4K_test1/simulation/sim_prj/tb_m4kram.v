//testbench for vgasdram
`

`timescale 1ns/1ns


module tb_m4kram;

reg clk;		//系统时钟，50MHz
reg rst_n;		//复位信号，低电平有效

reg ram_wr;			//RAM写入使能信号，高表示写入
reg[11:0] ram_addr;	//RAM地址总线
reg[7:0]  ram_din;	//RAM写入数据总线

wire[7:0] ram_dout;		//RAM读出数据总线

mem_cof	mem_cof(
			.clk(clk),
			.rst_n(rst_n),
			.ram_dout(ram_dout),
			.ram_wr(ram_wr),
			.ram_addr(ram_addr),
			.ram_din(ram_din)
		);


initial begin
	rst_n = 0;
	ram_wr = 0;
	ram_addr = 12'hzzz;
	ram_din = 8'hzz;
	#200;
	rst_n = 1;
	
	#3_000;	//delay 3us
	
	task_wr_ram(12'd0,8'd0);	//0地址写数据0
	task_wr_ram(12'd1,8'd1);	//1地址写数据1
	task_wr_ram(12'd2,8'd2);	//2地址写数据2
	task_wr_ram(12'd3,8'd3);	//3地址写数据3
	
	@(posedge clk);
	ram_addr = 12'd0;	//读0地址
	@(posedge clk);	
	ram_addr = 12'd1;	//读1地址
	@(posedge clk);
	ram_addr = 12'd2;	//读2地址
	@(posedge clk);
	ram_addr = 12'd3;	//读3地址
	
	#100;	
	$stop;	
end

initial begin
	clk = 0;
	forever
	#5 clk = ~clk;
end


//写入RAM任务
task task_wr_ram;
	input[11:0] t_addr;
	input[7:0] t_data;
	begin
		@(posedge clk);
		fork
		ram_wr = 1;
		ram_addr = t_addr;
		ram_din = t_data;
		join
		@(posedge clk);
		fork
		ram_wr = 0;
		ram_addr = 12'hzzz;
		ram_din = 8'hzz;
		join		
	end
endtask


endmodule

