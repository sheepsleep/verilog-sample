//testbench for vgasdram


`timescale 1ns/1ns


module tb_sdrtest;
/*
sdram	sd_model(
				.clk(sdram_clk),
				.csb(sdram_cs_n), 
				.cke(sdram_cke), 
				.ba(sdram_ba), 
				.ad(sdram_addr), 
				.rasb(sdram_ras_n), 
				.casb(sdram_cas_n), 
				.web(sdram_we_n), 
				.dqm(2'b00), 
				.dqi(sdram_data)
				);
*/

//print_task.v里包含常用信息打印任务封装
print_task	print();

//sys_ctrl_task.v里包含系统时钟产生单元和系统复位任务
sys_ctrl_task	sys_ctrl(
						.clk(clk),
						.rst_n(rst_n)
					);
					
	//input				
wire clk;		//系统时钟,25MHz
wire rst_n;		//复位信号，低电平有效

	//output
	// FPGA与SDRAM硬件接口
wire sdram_clk;				// SDRAM时钟信号
wire sdram_cke;				// SDRAM时钟有效信号
wire sdram_cs_n;			// SDRAM片选信号
wire sdram_ras_n;			// SDRAM行地址选通脉冲
wire sdram_cas_n;			// SDRAM列地址选通脉冲
wire sdram_we_n;			// SDRAM写允许位
wire[1:0] sdram_ba;			// SDRAM的L-Bank地址线
wire[11:0] sdram_addr;		// SDRAM地址总线
wire rs232_tx;				// 串口数据发送

//inout
wire[15:0] sdram_data;		// SDRAM数据总线


////////////////////////////////////////////////
	// SDRAM的封装接口测试引出
/*wire sdram_rd_ack;		//系统读SDRAM响应信号	
wire sdram_wr_ack;

wire[15:0] sys_data_in;
wire[15:0] sys_data_out;	//读SDRAM时数据暂存器,(格式同上)
wire sdram_busy;			// SDRAM忙标志，高表示SDRAM处于工作中
wire sys_dout_rdy;			// SDRAM数据输出完成标志

wire[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线	
wire rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效
*/
////////////////////////////////////////////////

sdr_test	sd(
			.clk(clk),
			.rst_n(rst_n),
			.sdram_clk(sdram_clk),
			.sdram_cke(sdram_cke),
			.sdram_cs_n(sdram_cs_n),
			.sdram_ras_n(sdram_ras_n),
			.sdram_cas_n(sdram_cas_n),
			.sdram_we_n(sdram_we_n),
			.sdram_ba(sdram_ba),
			.sdram_addr(sdram_addr),
			.sdram_data(sdram_data),
			.rs232_tx(rs232_tx)/*,
			.sdram_rd_req(sdram_rd_req),
			.sdram_wr_ack(sdram_wr_ack),
			.sdram_rd_ack(sdram_rd_ack),
			.sys_data_in(sys_data_in),
			.sys_data_out(sys_data_out),
			.sdram_busy(sdram_busy),
			.sys_dout_rdy(sys_dout_rdy),
			.rdf_dout(rdf_dout),
			.rdf_rdreq(rdf_rdreq)*/
		);


reg[15:0] sdram_datar;
reg sdatalink;				
assign sdram_data = sdatalink ? sdram_datar:16'hzzzz;

integer write_232rx_file;	//定义文件指针	
integer cnt512;			//512计数

initial begin
		//串口数据接收文件初始化
	write_232rx_file = $fopen("write_232rx_file.txt");//txt文件初始化
	$fdisplay(write_232rx_file,"rx232 receive data display:\n");
	cnt512 = 0;
	sdatalink = 0;
		//SDRAM输入接口初始化
	//sdatalink = 0;

		//系统复位
	sys_ctrl.sys_reset(400);	//有效复位400ns

	#200_000;	//等待200us

	//sdram_wr_task;
	#20_000;	//等待30us
	//sdram_rd_task;

		//等待，系统测试完成
	#30_000_000;		//等待30ms	
	print.terminate;		
end


//模拟sdram存储写入数据
reg[15:0] memd[255:0];	//256个16bit缓存
integer cnt;
always @(posedge sdram_clk) begin
	if({sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} == 5'b10011) begin	//行选通
		@(posedge sdram_clk); 
		@(posedge sdram_clk); 
		if({sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} == 5'b10100) begin	//写命令
			for(cnt=0;cnt<256;cnt=cnt+1) begin
				memd[cnt] = sdram_data;
				@(posedge sdram_clk);
			end	
		end
	end
end


//模拟sdram在数据读时将数据送出
integer cntrd;
always @(posedge sdram_clk) begin
	if({sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} == 5'b10011) begin	//行选通
		@(posedge sdram_clk); 
		@(posedge sdram_clk); 
		if({sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} == 5'b10101) begin	//读命令
			@(posedge sdram_clk); 
			@(posedge sdram_clk); 
			sdatalink = 1'b1;
			for(cntrd=0;cntrd<256;cntrd=cntrd+1) begin
				#5;
				sdram_datar = memd[cntrd];
				@(posedge sdram_clk);
			end
			@(posedge sdram_clk);
			sdatalink = 1'b0;	
		end
	end
end


//模拟串口接收
integer cntbit;		
reg[7:0] rxdata;	//串口接收数据寄存器
parameter	BPS9600		= 104_167;		//9600bps传输率
parameter	BPS9600_2	= 52_083;		//9600bps传输率
always @(negedge rs232_tx) begin
	if(!rs232_tx) begin
		#BPS9600;		//起始位等待
		#BPS9600_2;		//对齐数据中间
		for(cntbit=0;cntbit<8;cntbit=cntbit+1) begin	//采样8bit数据
			rxdata[cntbit] = rs232_tx;
			#BPS9600;		//等待下一位
		end
		if(!rs232_tx) print.error("rs232_tx stop bit error");	//结束位出错报告
		else #BPS9600_2;		//等待结束位完成
		$fdisplay(write_232rx_file,"Receive data %d  :  %d\n",cnt512,rxdata);		//将当前接收到的串口数据输出到write_232rx_file.txt中
		$write("current receive data is %d\n",rxdata);
		cnt512 = cnt512+1;
	end
	
end



endmodule

