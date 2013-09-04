`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.05
// Design Name	: 
// Module Name	: spi_ctrl
// Project Name	: sdrsvgaprj
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 
//				
// Revision		: V1.0
// Additional Comments	:  
// 
////////////////////////////////////////////////////////////////////////////////
module spi_ctrl(
			clk,rst_n,
			spi_miso,spi_mosi,spi_clk,
			spi_tx_en,spi_tx_rdy,spi_rx_en,spi_rx_rdy,spi_tx_db,spi_rx_db
			);

input clk;		//FPAG输入时钟信号25MHz
input rst_n;	//FPGA输入复位信号

input spi_miso;		//SPI主机输入从机输出数据信号
output spi_mosi;	//SPI主机输出从机输入数据信号
output spi_clk;		//SPI时钟信号，由主机产生

input spi_tx_en;		//SPI数据发送使能信号，高有效
output spi_tx_rdy;		//SPI数据发送完成标志位，高有效
input spi_rx_en;		//SPI数据接收使能信号，高有效
output spi_rx_rdy;		//SPI数据接收完成标志位，高有效
input[7:0] spi_tx_db;	//SPI数据发送寄存器
output[7:0] spi_rx_db;	//SPI数据接收寄存器


//模拟SPI的时序模式为CPOL=1, CPHA=1,模拟速率为25Mbit

//-------------------------------------------------
//SPI时序控制计数器，所有SPI时序由该计数器值控制
reg[4:0] cnt8;	//SPI时序控制计数器,计数范围在0-18

always @(posedge clk or negedge rst_n)
	if(!rst_n) cnt8 <= 5'd0;
	else if(spi_tx_en || spi_rx_en) begin
			if(cnt8 < 5'd18)cnt8 <= cnt8+1'b1;	//SPI工作使能
			else ;	//计数到18停止，等待撤销spi使能
		end
	else cnt8 <= 5'd0;	//SPI关闭，计数停止

//-------------------------------------------------
//SPI时钟信号产生
reg spi_clkr;	//SPI时钟信号，由主机产生

always @(posedge clk or negedge rst_n)
	if(!rst_n) spi_clkr <= 1'b1;
	else if(cnt8 > 5'd1 && cnt8 < 5'd18) spi_clkr <= ~spi_clkr;	//在cnt8处于2-17时SPI时钟有效翻转

assign spi_clk = spi_clkr;

//-------------------------------------------------
//SPI主机输出数据控制
reg spi_mosir;	//SPI主机输出从机输入数据信号

always @(posedge clk or negedge rst_n)
	if(!rst_n) spi_mosir <= 1'b1;
	else if(spi_tx_en) begin
			case(cnt8[4:1])		//主机发送8bit数据
				4'd1: spi_mosir <= spi_tx_db[7];	//发送bit7
				4'd2: spi_mosir <= spi_tx_db[6];	//发送bit6
				4'd3: spi_mosir <= spi_tx_db[5];	//发送bit5
				4'd4: spi_mosir <= spi_tx_db[4];	//发送bit4
				4'd5: spi_mosir <= spi_tx_db[3];	//发送bit3
				4'd6: spi_mosir <= spi_tx_db[2];	//发送bit2
				4'd7: spi_mosir <= spi_tx_db[1];	//发送bit1
				4'd8: spi_mosir <= spi_tx_db[0];	//发送bit0
				default: spi_mosir <= 1'b1;	//spi_mosi没有输出时应保持高电平
				endcase
		end
	else spi_mosir <= 1'b1;	//spi_mosi没有输出时应保持高电平

assign spi_mosi = spi_mosir;

//-------------------------------------------------
//SPI主机输入数据控制
reg[7:0] spi_rx_dbr;	//SPI主机输入从机输出数据总线寄存器

always @(posedge clk or negedge rst_n)
	if(!rst_n) spi_rx_dbr <= 8'hff;
	else if(spi_rx_en) begin
			case(cnt8)		//主机接收并锁存8bit数据
				5'd3: spi_rx_dbr[7] <= spi_miso;	//接收bit7
				5'd5: spi_rx_dbr[6] <= spi_miso;	//接收bit6
				5'd7: spi_rx_dbr[5] <= spi_miso;	//接收bit5
				5'd9: spi_rx_dbr[4] <= spi_miso;	//接收bit4
				5'd11: spi_rx_dbr[3] <= spi_miso;	//接收bit3
				5'd13: spi_rx_dbr[2] <= spi_miso;	//接收bit2
				5'd15: spi_rx_dbr[1] <= spi_miso;	//接收bit1
				5'd17: spi_rx_dbr[0] <= spi_miso;	//接收bit0
				default: ;
				endcase
		end

assign spi_rx_db = spi_rx_dbr;

//-------------------------------------------------
//SPI数据发送完成标志位，高有效
assign spi_tx_rdy = (cnt8 == 5'd18)/* & spi_tx_en)*/;

//-------------------------------------------------
//SPI数据接收完成标志位，高有效
assign spi_rx_rdy = (cnt8 == 5'd18)/* & spi_rx_en)*/;


endmodule
