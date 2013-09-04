`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.15
// Design Name	: 
// Module Name	: vga_ctrl
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module vga_ctrl(	
				clk,rst_n,
				disp_ctrl,
				dis_data,vga_valid,rdf_rdreq,
				hsync,vsync,vga_r,vga_g,vga_b
			);

input clk;		// 50MHz
input rst_n;	//低电平复位

input[7:0] dis_data;	//VGA显示数据
input disp_ctrl;		//外部控制LCD显示使能信号
output vga_valid;		//高有效，用于使能SDRAM读数据单元进行寻址或地址清零
output rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效

	// FPGA与VGA接口信号
output hsync;	//行同步信号
output vsync;	//场同步信号
output[2:0] vga_r;
output[2:0] vga_g;
output[1:0] vga_b;

//--------------------------------------------------
	// 坐标计数
reg[10:0] x_cnt;	//行坐标0-1039
reg[9:0] y_cnt;		//列坐标0-665

always @ (posedge clk or negedge rst_n)
	if(!rst_n) x_cnt <= 11'd0;
	else if(!disp_ctrl) x_cnt <= 11'd0;	//关显示
	else if(x_cnt == 11'd1039) x_cnt <= 11'd0;
	else x_cnt <= x_cnt+1'b1;			//x坐标计数

always @ (posedge clk or negedge rst_n)
	if(!rst_n) y_cnt <= 10'd0;
	else if(!disp_ctrl) y_cnt <= 10'd0;	//关显示
	else if(y_cnt == 10'd665) y_cnt <= 10'd0;
	else if(x_cnt == 11'd1039) y_cnt <= y_cnt+1'b1;	//y坐标计数

//--------------------------------------------------
	//有效显示标志位产生
reg valid_yr;	//行显示有效信号

always @ (posedge clk or negedge rst_n)
	if(!rst_n) valid_yr <= 1'b0;
	else if(y_cnt == 10'd31) valid_yr <= 1'b1;	//行有效显示区
	else if(y_cnt == 10'd631) valid_yr <= 1'b0;	

reg valid_r;
wire valid;		//有效显示区标志

always @ (posedge clk or negedge rst_n)
	if(!rst_n) valid_r <= 1'b0;
	else if(x_cnt == 11'd187) valid_r <= 1'b1;	//列有效显示区
	else if(x_cnt == 11'd987) valid_r <= 1'b0;
	
assign valid = valid_r & valid_yr;	// VGA有效显示区标志位

//--------------------------------------------------
	// VGA场同步,行同步信号
reg hsync_r,vsync_r;	//同步信号

always @ (posedge clk or negedge rst_n)
	if(!rst_n) hsync_r <= 1'b1;								
	else if(x_cnt == 11'd0) hsync_r <= 1'b0;	//产生hsync信号
	else if(x_cnt == 11'd120) hsync_r <= 1'b1;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) vsync_r <= 1'b1;							  
	else if(y_cnt == 10'd0) vsync_r <= 1'b0;	//产生vsync信号
	else if(y_cnt == 10'd6) vsync_r <= 1'b1;

assign hsync = hsync_r;
assign vsync = vsync_r;

//--------------------------------------------------
	//读FIFO数据使能，送显示数据

assign rdf_rdreq = ((x_cnt >= 11'd183) & (x_cnt < 11'd983) 
					& (y_cnt > 10'd30) & (y_cnt <= 10'd630));

//--------------------------------------------------
	//使能SDRAM读数据单元进行寻址或地址清零
assign vga_valid = (y_cnt >= 10'd30) & (y_cnt <= 10'd630);

//-------------------------------------------------- 
	// VGA色彩信号产生
reg[7:0] vga_rgb;	// VGA色彩显示寄存器

always @ (posedge clk)
	if(!valid) vga_rgb <= 8'd0;
	else vga_rgb <= dis_data;

	//r,g,b控制液晶屏颜色显示
assign vga_r = vga_rgb[2:0];
assign vga_g = vga_rgb[5:3];
assign vga_b = vga_rgb[7:6];

endmodule
