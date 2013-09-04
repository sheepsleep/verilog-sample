//testbench for logic_analysis.prj
`timescale 1ns/1ns

module tb_seg7;

//print_task.v里包含常用信息打印任务封装
print_task	print();

//sys_ctrl_task.v里包含系统时钟产生单元和系统复位任务
sys_ctrl_task	sys_ctrl(
						.clk(clk),
						.rst_n(rst_n)
					);
//input
wire clk;	//FPAG输入时钟信号25MHz
wire rst_n;	//FPGA输入复位信号

//output
wire ds_stcp;		//74HC595的并行时钟输入，上升沿将当前串行输入数据并行输出
wire ds_shcp;		//74HC595的串行时钟输入，上升沿锁存当前串行输入数据
wire ds_data;		//74HC595的串行数据输入


seg7		uut(
					.clk(clk),
					.rst_n(rst_n),
					.ds_stcp(ds_stcp),
					.ds_shcp(ds_shcp),
					.ds_data(ds_data)
				);

//--------------------------------------------------

//仿真测试中

initial begin

		//系统复位
	sys_ctrl.sys_reset(400);	//有效复位400ns
	
	
		//等待，系统测试完成
	#300_000;	
	print.terminate;	
end


	
endmodule
