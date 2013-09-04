`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.27
// Design Name	: vga_char
// Module Name	: vga_char
// Project Name	: vga_char
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 连接SF-EP1C6开发板的VGA接口和电脑液晶屏，
//					显示字符"EDN"
// Revision		: V1.0
// Additional Comments	:  
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module vga_char(	
				clk_25m,rst_n,	//系统控制
				hsync,vsync,vga_r,vga_g,vga_b	// VGA控制
			);

input clk_25m;	// 25MHz
input rst_n;	//低电平复位

	// FPGA与VGA接口信号
output hsync;	//行同步信号
output vsync;	//场同步信号
output[2:0] vga_r;
output[2:0] vga_g;
output[1:0] vga_b;

//--------------------------------------------------
	// 坐标计数
reg[9:0] x_cnt;		//行坐标
reg[9:0] y_cnt;		//列坐标

always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) x_cnt <= 10'd0;
	else if(x_cnt == 10'd799) x_cnt <= 10'd0;
	else x_cnt <= x_cnt+1'b1;

always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) y_cnt <= 10'd0;
	else if(y_cnt == 10'd524) y_cnt <= 10'd0;
	else if(x_cnt == 10'd799) y_cnt <= y_cnt+1'b1;

//--------------------------------------------------
	// VGA场同步,行同步信号
reg hsync_r,vsync_r;	//同步信号
 
always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) hsync_r <= 1'b1;								
	else if(x_cnt == 10'd0) hsync_r <= 1'b0;	//产生hsync信号
	else if(x_cnt == 10'd96) hsync_r <= 1'b1;

always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) vsync_r <= 1'b1;							  
	else if(y_cnt == 10'd0) vsync_r <= 1'b0;	//产生vsync信号
	else if(y_cnt == 10'd2) vsync_r <= 1'b1;

assign hsync = hsync_r;
assign vsync = vsync_r;

//--------------------------------------------------
	//有效显示标志位产生
reg valid_yr;	//行显示有效信号
always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) valid_yr <= 1'b0;
	else if(y_cnt == 10'd32) valid_yr <= 1'b1;
	else if(y_cnt == 10'd512) valid_yr <= 1'b0;	

wire valid_y = valid_yr;

reg valid_r;	// VGA有效显示区标志位
always @ (posedge clk_25m or negedge rst_n)
	if(!rst_n) valid_r <= 1'b0;
	else if((x_cnt == 10'd141) && valid_y) valid_r <= 1'b1;
	else if((x_cnt == 10'd781) && valid_y) valid_r <= 1'b0;
	
wire valid = valid_r;		

//wire[9:0] x_dis;		//横坐标显示有效区域相对坐标值0-639
wire[9:0] y_dis;		//竖坐标显示有效区域相对坐标值0-479

//assign x_dis = x_cnt - 10'd142;
assign y_dis = y_cnt - 10'd33;
//--------------------------------------------------

//-------------------------------------------------- 
	// VGA色彩信号产生
/*
RGB = 000  	黑色	RGB = 100	红色
	= 001  	蓝色		= 101	紫色
	= 010	绿色		= 110	黄色
	= 011	青色		= 111	白色
*/	

/*EDN字模参数*/
/*parameter 	char_line0 = 24'h000000,
			char_line1 = 24'h000000,
			char_line2 = 24'h000000,
			char_line3 = 24'hfcf8c7,
			char_line4 = 24'h424462,
			char_line5 = 24'h484262,
			char_line6 = 24'h484252,
			char_line7 = 24'h784252,
			char_line8 = 24'h48424a,
			char_line9 = 24'h48424a,
			char_linea = 24'h40424a,
			char_lineb = 24'h424246,
			char_linec = 24'h424446,
			char_lined = 24'hfcf8e2,
			char_linee = 24'h000000,
			char_linef = 24'h000000;
*/
reg[5:0] rom_addr;		//ROM地址
reg[7:0] rom_data;		//ROM数据

vga_rom		uut_vga_rom(
				.address(rom_addr),
				.clock(clk_25m),
				.q(rom_data)
				);

	//ROM地址计算
always @(posedge clk_25m or negedge rst_n)
	if(!rst_n) rom_addr <= 6'd0;
	else if(y_dis == 10'd230) rom_addr <= 6'h3f;	//地址复位
	else if(y_dis > 10'd230 && y_dis < 10'd467 && (x_cnt == 10'd440 | x_cnt == 10'd448 | x_cnt == 10'd456))
		rom_addr <= rom_addr+1'b1;

reg[4:0] char_bit;	//显示位计算

always @(posedge clk_25m or negedge rst_n)
	if(!rst_n) char_bit <= 5'h1f;
	else if(x_cnt == 10'd442) char_bit <= 5'd23;	//显示最高位数据
	else if(x_cnt > 10'd442 && x_cnt < 10'd466) char_bit <= char_bit-1'b1;	//依次显示后面的数据
	
reg[7:0] vga_rgb;	// VGA色彩显示寄存器

always @ (posedge clk_25m)
	if(!valid) vga_rgb <= 8'd0;
	else if(x_cnt > 10'd442 && x_cnt < 10'd467) begin
		case(y_dis)
			10'd231: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd232: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd233: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd234: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd235: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd236: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd237: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd238: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd239: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd240: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色
			10'd241: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色		 		 		 		 		 
			10'd242: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色			 
			10'd243: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色	
			10'd244: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色	
			10'd245: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色	
			10'd246: if(rom_data[char_bit]) vga_rgb <= 8'b11_000_000;	//红色
					 else vga_rgb <= 8'b00_111_000;	//绿色			 		 		 		 
		default: vga_rgb <= 8'h00;
		endcase
	end
	else vga_rgb <= 8'h00;

	//r,g,b控制液晶屏颜色显示
assign vga_r = vga_rgb[7:5];
assign vga_g = vga_rgb[4:2];
assign vga_b = vga_rgb[1:0];

endmodule
