`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdfifo_ctrl
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: SDRAM fifo控制模块						
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module sdfifo_ctrl(
				clk_50m,clk_100m,rst_n,
				wrf_din,wrf_wrreq,
				sdram_wr_ack,sys_wraddr,sys_rdaddr,sys_data_in,sdram_wr_req,
				sys_data_out,rdf_rdreq,sdram_rd_ack,/*rdf_dout,*/sdram_rd_req,
				vga_valid,dis_data,sdwrad_clr
			);

input clk_50m;	//PLL输出50MHz时钟
input clk_100m;	//PLL输出100MHz时钟
input rst_n;	//系统复位信号，低有效

	//wrfifo
input wrf_wrreq;			//sdram数据写入缓存FIFO数据输入请求，高有效
input sdram_wr_ack;			//系统写SDRAM响应信号,作为wrFIFO的输出有效信号
input[15:0] wrf_din;		//sdram数据写入缓存FIFO输入数据总线
output sdram_wr_req;		//系统写SDRAM请求信号
output[15:0] sys_data_in;	//sdram数据写入缓存FIFO输出数据总线，即写SDRAM时数据暂存器
output[21:0] sys_wraddr;	//写SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 

	//rdfifo
input rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效
input sdram_rd_ack;			//系统读SDRAM响应信号,作为rdFIFO的输写有效信号
input[15:0] sys_data_out;	//sdram数据读出缓存FIFO输入数据总线
output sdram_rd_req;		//系统读SDRAM请求信号
output[21:0] sys_rdaddr;	//读SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 

	//vga control
input vga_valid;		//高有效，用于使能SDRAM读数据单元进行寻址或地址清零
output[7:0] dis_data;	//VGA显示数据

input sdwrad_clr;		//SDRAM写控制相关信号清零复位信号，高有效

//------------------------------------------------
//读写sdram请求信号产生
wire[8:0] wrf_use;			//sdram数据写入缓存FIFO已用存储空间数量
wire[8:0] rdf_use;			//sdram数据读出缓存FIFO已用存储空间数量	

reg vga_validr;		//将50M时钟域的vga_valid打一拍以同步到100M的vga_validr
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) vga_validr <= 1'b0;
	else vga_validr <= vga_valid;
	
assign sdram_wr_req = (wrf_use >= 9'd256);	//FIFO（256个16bit数据）即发出写SDRAM请求信号
assign sdram_rd_req = (rdf_use < 9'd480) & vga_validr;	//VGA显示有效且FIFO半空（256个16bit数据）即发出读SDRAM请求信号

//------------------------------------------------
//sdram读写响应完成标致捕获
reg sdwrackr1,sdwrackr2;	//sdram_wr_ack寄存器
reg sdrdackr1,sdrdackr2;	//sdram_rd_ack寄存器

	//锁存两拍sdram_wr_ack，用于下降沿捕获
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) begin
			sdwrackr1 <= 1'b0;
			sdwrackr2 <= 1'b0;
		end
	else begin
			sdwrackr1 <= sdram_wr_ack;
			sdwrackr2 <= sdwrackr1;			
		end
		
wire neg_sdwrack = ~sdwrackr1 & sdwrackr2;	//sdram_wr_ack下降沿标志位，高有效一个时钟周期

	//锁存两拍sdram_rd_ack，用于下降沿捕获
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) begin
			sdrdackr1 <= 1'b0;
			sdrdackr2 <= 1'b0;
		end
	else begin
			sdrdackr1 <= sdram_rd_ack;
			sdrdackr2 <= sdrdackr1;			
		end
		
wire neg_sdrdack = ~sdrdackr1 & sdrdackr2;	//sdram_rd_ack下降沿标志位，高有效一个时钟周期

//------------------------------------------------
//sdram读写地址产生逻辑
reg[13:0] sys_wrabr;	//sdram写地址寄存器,对应sdram_addr[21:8]
reg[16:0] sys_rdabr;	//sdram读地址寄存器,对应sdram_addr[21:5]

	//sdram写地址产生
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) sys_wrabr <= 14'd0;
	else if(sdwrad_clr)	sys_wrabr <= 14'd0;	//写入地址复位，重新写入新图片数据
	else if(neg_sdwrack) sys_wrabr <= sys_wrabr+1'b1;	//一次写入完成后地址递增8

reg[4:0] cnt25;	//0-99计数器
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) cnt25 <= 5'd0;
	else if(!vga_validr) cnt25 <= 5'd0;
	else if(neg_sdrdack) begin
		if(cnt25 < 5'd24) cnt25 <= cnt25+1'b1;
		else cnt25 <= 5'd0;
	end

	//sdram读地址产生
always @(posedge clk_100m or negedge rst_n)
	if(!rst_n) sys_rdabr <= 17'd0;
	else if(!vga_validr) sys_rdabr <= 17'd14975;	//从末-800地址读数据
	else if(neg_sdrdack) begin
		if(cnt25 == 5'd24) sys_rdabr <= sys_rdabr-17'd49;
		else sys_rdabr <= sys_rdabr+1'b1;	//一次读出完成后地址递增	
	end

assign sys_wraddr = {sys_wrabr,8'h00};
assign sys_rdaddr = {sys_rdabr,5'd0};

//------------------------------------------------
//sd卡读出数据写入SDRAM_wrfifo或者vgaram
reg[10:0] cnt78;	//计数到1078

	//cnt78计数0-53（SD数据不缓存）和54-1077（SD数据表译码），1078计数停止（SD数据写入SDRAM）
always @(posedge clk_50m or negedge rst_n)
	if(!rst_n) cnt78 <= 11'd0;
	else if(sdwrad_clr) cnt78 <= 11'd0;		//重新下一幅图片
	else if((cnt78 < 11'd1078) && wrf_wrreq) cnt78 <= cnt78+1'b1;

wire bmpvt_wren = (cnt78 > 11'd53) & (cnt78 < 11'd1078) & wrf_wrreq;	//SD接收数据写入VGA色彩表RAM
wire bmpsd_wren = (cnt78 == 11'd1078) & wrf_wrreq;	//SD接收数据存储到SDRAM wrfifo

//------------------------------------------------
//例化SDRAM写入数据缓存FIFO模块
wrfifo			uut_wrfifo(
					.aclr(sdwrad_clr),
					.data(wrf_din),
					.rdclk(clk_100m),
					.rdreq(sdram_wr_ack),
					.wrclk(clk_50m),
					.wrreq(bmpsd_wren),
					.q(sys_data_in),
					.wrusedw(wrf_use)
					);	

//------------------------------------------------
//例化SDRAM读出数据缓存FIFO模块
wire[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线
rdfifo			uut_rdfifo(
					.aclr(~vga_validr),
					.data(sys_data_out),
					.rdclk(clk_50m),
					.rdreq(rdf_rdreq),
					.wrclk(clk_100m),
					.wrreq(sdram_rd_ack),
					.q(rdf_dout),
					.wrusedw(rdf_use)
					);

//------------------------------------------------
//例化256字节RAM存放BMP图片的色彩表译码数据
reg[7:0] rr_din;	//RAM输入数据
wire[7:0] rr_dout;	//RAM输出数据
wire[7:0] rr_addr;	//RAM读写地址

rgb_ram			uut_rgbram(
					.address(rr_addr),	///////////
					.data(rr_din),
					.clock(clk_50m),
					.wren(rr_wr),
					.q(rr_dout)		
					);

//-------------------------------------------------
//BMP色彩表数据译码以及写使能信号产生
reg[1:0] cnt4;	//四字节数据寄存器

	//
always @(posedge clk_50m or negedge rst_n)
	if(!rst_n) cnt4 <= 2'd0;
	else if(sdwrad_clr) cnt4 <= 2'd0;	//重新下一幅图片
	else if(bmpvt_wren) cnt4 <= cnt4+1'b1;

	//4字节色彩表译码,BMP
	/*色彩表用4个字节表示一个色彩，这里我们只取其中有用的数据拼凑成1个字节保存即可。*/
always @(posedge clk_50m or negedge rst_n)
	if(!rst_n) rr_din <= 8'd0;
	else if(bmpvt_wren) begin
		case(cnt4)
				2'd0: rr_din[7:6] <= wrf_din[7:6];		//2blue--2blue
				2'd1: rr_din[5:3] <= wrf_din[7:5];		//3green--3green
				2'd2: rr_din[2:0] <= wrf_din[7:5];		//3red--3red
			default: ;
			endcase
	end

wire rr_wr = bmpvt_wren & (cnt4 == 2'd3);	//vgaRAM写使能信号

//-------------------------------------------------
//BMP色彩表读写地址产生
reg[7:0] rr_wraddr;	//vgaRAM写入地址产生

always @(posedge clk_50m or negedge rst_n)
	if(!rst_n) rr_wraddr <= 8'd0;
	else if(sdwrad_clr) rr_wraddr <= 8'd0;	//重新下一幅图片
	else if(rr_wr) rr_wraddr <= rr_wraddr+1'b1;

assign rr_addr = (cnt78 < 11'd1078) ? rr_wraddr : rdf_dout[7:0];

assign dis_data = rr_dout;	//译码后的显示数据	


endmodule
