`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company		: 
// Engineer		: 特权 franchises3
// Create Date	: 2009.05.11
// Design Name	: 
// Module Name	: sdr_test
// Project Name	: 
// Target Device: Cyclone EP1C3T144C8 
// Tool versions: Quartus II 8.1
// Description	: 
//				
// Revision		: V1.0
// Additional Comments	:  
// 欢迎加入EDN的FPGA/CPLD助学小组一起讨论：http://group.ednchina.com/1375/
////////////////////////////////////////////////////////////////////////////////
module sdr_test(
				clk,rst_n,
				sdram_clk,sdram_cke,sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n,
				sdram_ba,sdram_addr,sdram_data,//sdram_udqm,sdram_ldqm	
				spi_miso,spi_mosi,spi_clk,spi_cs_n,
				hsync,vsync,vga_r,vga_g,vga_b
			);

input clk;			//系统时钟，25MHz
input rst_n;		//复位信号，低电平有效

	// FPGA与SDRAM硬件接口
output sdram_clk;			//	SDRAM时钟信号
output sdram_cke;			//  SDRAM时钟有效信号
output sdram_cs_n;			//	SDRAM片选信号
output sdram_ras_n;			//	SDRAM行地址选通脉冲
output sdram_cas_n;			//	SDRAM列地址选通脉冲
output sdram_we_n;			//	SDRAM写允许位
output[1:0] sdram_ba;		//	SDRAM的L-Bank地址线
output[11:0] sdram_addr;	//  SDRAM地址总线
//output sdram_udqm;			// SDRAM高字节屏蔽
//output sdram_ldqm;			// SDRAM低字节屏蔽
inout[15:0] sdram_data;		// SDRAM数据总线

	// SD硬件接口
input spi_miso;		//SPI主机输入从机输出数据信号
output spi_mosi;	//SPI主机输出从机输入数据信号
output spi_clk;		//SPI时钟信号，由主机产生
output spi_cs_n;	//SPI从设备使能信号，由主设备控制

	// FPGA与VGA接口信号
output hsync;	//行同步信号
output vsync;	//场同步信号
output[2:0] vga_r;
output[2:0] vga_g;
output[1:0] vga_b;

	// SDRAM的封装接口
wire sdram_wr_req;			//系统写SDRAM请求信号
wire sdram_rd_req;			//系统读SDRAM请求信号
wire sdram_wr_ack;			//系统写SDRAM响应信号,作为wrFIFO的输出有效信号
wire sdram_rd_ack;			//系统读SDRAM响应信号,作为rdFIFO的输写有效信号	
wire[8:0] sdwr_byte = 9'd256;		//突发写SDRAM字节数（1-256个）
wire[8:0] sdrd_byte = 9'd32;		//突发读SDRAM字节数（1-256个）
wire[21:0] sys_wraddr;		//写SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 
wire[21:0] sys_rdaddr;		//读SDRAM时地址暂存器，(bit21-20)L-Bank地址:(bit19-8)为行地址，(bit7-0)为列地址 
wire[15:0] sys_data_in;		//写SDRAM时数据暂存器

wire[15:0] sys_data_out;	//sdram数据读出缓存FIFO输入数据总线
//wire sdram_busy;			// SDRAM忙标志，高表示SDRAM处于工作中
//wire sys_dout_rdy;			// SDRAM数据输出完成标志

	//wrFIFO输入控制接口
wire[15:0] wrf_din;		//sdram数据写入缓存FIFO输入数据总线
wire wrf_wrreq;			//sdram数据写入缓存FIFO数据输入请求，高有效
wire sdwrad_clr;		//SDRAM写控制相关信号清零复位信号，高有效

	//rdFIFO输出控制接口
//wire[15:0] rdf_dout;		//sdram数据读出缓存FIFO输出数据总线	
wire rdf_rdreq;			//sdram数据读出缓存FIFO数据输出请求，高有效

	//系统控制相关信号接口
wire clk_50m;	//PLL输出50MHz时钟
wire clk_100m;	//PLL输出100MHz时钟
wire sys_rst_n;	//系统复位信号，低有效

wire vga_valid;		//高有效，用于使能SDRAM读数据单元进行寻址或地址清零
wire[7:0] dis_data;	//VGA显示数据

//------------------------------------------------
//例化系统复位信号和PLL控制模块
sys_ctrl		uut_sysctrl(
					.clk(clk),
					.rst_n(rst_n),
					.sys_rst_n(sys_rst_n),
					.clk_50m(clk_50m),
					.clk_100m(clk_100m),
					.sdram_clk(sdram_clk)
					);

//------------------------------------------------
//例化SDRAM封装控制模块
sdram_top		uut_sdramtop(				// SDRAM
							.clk(clk_100m),
							.rst_n(sys_rst_n),
							.sdram_wr_req(sdram_wr_req),
							.sdram_rd_req(sdram_rd_req),
							.sdram_wr_ack(sdram_wr_ack),
							.sdram_rd_ack(sdram_rd_ack),	
							.sys_wraddr(sys_wraddr),
							.sys_rdaddr(sys_rdaddr),
							.sys_data_in(sys_data_in),
							.sys_data_out(sys_data_out),
							.sdwr_byte(sdwr_byte),
							.sdrd_byte(sdrd_byte),	
							//.sdram_clk(sdram_clk),
							//.sdram_busy(sdram_busy),
							.sdram_cke(sdram_cke),
							.sdram_cs_n(sdram_cs_n),
							.sdram_ras_n(sdram_ras_n),
							.sdram_cas_n(sdram_cas_n),
							.sdram_we_n(sdram_we_n),
							.sdram_ba(sdram_ba),
							.sdram_addr(sdram_addr),
							.sdram_data(sdram_data)
						//	.sdram_udqm(sdram_udqm),
						//	.sdram_ldqm(sdram_ldqm)
					);
	

//------------------------------------------------
//读写SDRAM数据缓存FIFO模块例化	
sdfifo_ctrl			uut_sdffifoctrl(
						.clk_50m(clk_50m),
						.clk_100m(clk_100m),
						.rst_n(sys_rst_n),
						.wrf_din(wrf_din),
						.wrf_wrreq(wrf_wrreq),
						.sdram_wr_ack(sdram_wr_ack),
						.sys_wraddr(sys_wraddr),
						.sys_rdaddr(sys_rdaddr),
						.sys_data_in(sys_data_in),
						.sdram_wr_req(sdram_wr_req),
						.sys_data_out(sys_data_out),
						.rdf_rdreq(rdf_rdreq),
						.sdram_rd_ack(sdram_rd_ack),
						.sdram_rd_req(sdram_rd_req),
						.vga_valid(vga_valid),
						.dis_data(dis_data),
						.sdwrad_clr(sdwrad_clr)
						);	
						
//------------------------------------------------
//例化VGA显示模块
vga_ctrl		uut_vgactrl(	
						.clk(clk_50m),
						.rst_n(sys_rst_n),
						.disp_ctrl(1'b1),	//始终开显示
						.dis_data(dis_data),
						.vga_valid(vga_valid),
						.rdf_rdreq(rdf_rdreq),
						.hsync(hsync),
						.vsync(vsync),
						.vga_r(vga_r),
						.vga_g(vga_g),
						.vga_b(vga_b)
					);

//------------------------------------------------
//例化sd控制模块
sdcard_ctrl		uut_sdcartctrl(
					.clk(clk_50m),
					.rst_n(sys_rst_n),
					.spi_miso(spi_miso),
					.spi_mosi(spi_mosi),
					.spi_clk(spi_clk),
					.spi_cs_n(spi_cs_n),
					.sd_dout(wrf_din[7:0]),		//8bit
					.sd_fifowr(wrf_wrreq),
					.sdwrad_clr(sdwrad_clr)
				);

endmodule
