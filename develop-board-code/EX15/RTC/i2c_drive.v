////////////////////////////////////////////////////////////////////////////////
//  Company: 成都锐创智能科技 Ruichuang Smart Technology                      //
//           http://ruicstech.taobao.com                                      // 
//  Engineer:      Youzhiyu                                                   //
//  QQ      :      4016682                                                    //
//  Target Device: MAXII240T100C5N                                            //
//  Tool versions: Quartus II 7.2                                             //
//  Create Date:   2011-09-06 10:09                                           //
//  Description:                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved                //
//----------------------------------------------------------------------------//
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module i2c_drive(
			clk,
			rst_n,
			wr_n,
			rd_n,
			scl,
			sda,
			write_data,
			addr,
			read_data,
			idle_state
		);

input  clk;		// 50MHz
input  rst_n;	//复位信号，低有效
input  wr_n;	//写允许信号，低电平有效
input  rd_n;	//读允许信号，低电平有效
output scl;		// I2C的时钟端口
inout  sda;		// I2C的数据端口
input  [7:0] write_data; //写入指定单元的数据
input  [7:0] addr;        //写入/读出的地址
output [7:0] read_data;	 //读出指定单元的数据
output reg idle_state;       //i2c总线空闲状态，低电平指示空闲
//--------------------------------------------
//读写信号检测
reg sw1_r,sw2_r;	//读写信号锁存寄存器，每20ms检测一次
reg [19:0] cnt_20ms;//20ms计数寄存器
reg  clr_sw;        //清除 读写信号锁存寄存器值  的标志

always @ (posedge clk or negedge rst_n)
	if(!rst_n) 
	   cnt_20ms <= 20'd0;
	else 
	   cnt_20ms <= cnt_20ms+1'b1;	//不断计数

always @ (posedge clk or negedge rst_n)
	if(!rst_n) 
		begin
			sw1_r <= 1'b1;	//读写信号锁存寄存器复位
			sw2_r <= 1'b1;
		end
	else if(cnt_20ms == 20'h7ffff) 
		begin
			sw1_r <= wr_n;	//写信号值锁存
			sw2_r <= rd_n;	//读信号值锁存
		end
	else if(clr_sw)
	    begin
            sw1_r<=1'b1;
            sw2_r<=1'b1;
        end
//---------------------------------------------
//分频部分
reg[2:0] cnt;	    // cnt=0:scl上升沿，cnt=1:scl高电平中间，cnt=2:scl下降沿，cnt=3:scl低电平中间
reg[8:0] cnt_delay;	//500循环计数，产生iic所需要的时钟
reg scl_r;		    //时钟脉冲寄存器

always @ (posedge clk or negedge rst_n)
	if(!rst_n) 
	   cnt_delay <= 9'd0;
	else if(cnt_delay == 9'd499) 
	   cnt_delay <= 9'd0;	//计数到10us为scl的周期，即100KHz
	else 
	   cnt_delay <= cnt_delay+1'b1;	//时钟计数

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
	   cnt <= 3'd5;
	else 
	  begin
		 case (cnt_delay)
			9'd124:	cnt <= 3'd1;	//cnt=1:scl高电平中间,用于数据采样
			9'd249:	cnt <= 3'd2;	//cnt=2:scl下降沿
			9'd374:	cnt <= 3'd3;	//cnt=3:scl低电平中间,用于数据变化
			9'd499:	cnt <= 3'd0;	//cnt=0:scl上升沿
			default: cnt <= 3'd5;
		  endcase
	  end
end


`define SCL_POS		(cnt==3'd0)		//cnt=0:scl上升沿
`define SCL_HIG		(cnt==3'd1)		//cnt=1:scl高电平中间,用于数据采样
`define SCL_NEG		(cnt==3'd2)		//cnt=2:scl下降沿
`define SCL_LOW		(cnt==3'd3)		//cnt=3:scl低电平中间,用于数据变化


always @ (posedge clk or negedge rst_n)
	if(!rst_n) 
	    scl_r <= 1'b0;
	else if(cnt==3'd0) 
	    scl_r <= 1'b1;	//scl信号上升沿
   	else if(cnt==3'd2) 
        scl_r <= 1'b0;	//scl信号下降沿

assign scl = scl_r;	//产生i2c所需要的时钟
//---------------------------------------------

//PCF8563T的地址		
`define	DEVICE_READ		8'b1010_0011	//被寻址器件地址（读操作）
`define DEVICE_WRITE	8'b1010_0010	//被寻址器件地址（写操作）
	
reg[7:0] db_r;		//在i2c上传送的数据寄存器


//---------------------------------------------
//读、写时序
parameter 	IDLE 	= 4'd0;
parameter 	START1 	= 4'd1;
parameter 	ADD1 	= 4'd2;
parameter 	ACK1 	= 4'd3;
parameter 	ADD2 	= 4'd4;
parameter 	ACK2 	= 4'd5;
parameter 	START2 	= 4'd6;
parameter 	ADD3 	= 4'd7;
parameter 	ACK3	= 4'd8;
parameter 	DATA 	= 4'd9;
parameter 	ACK4	= 4'd10;
parameter 	STOP1 	= 4'd11;
parameter 	STOP2 	= 4'd12;
	

reg[3:0] cstate;//状态寄存器
reg sda_r;		//输出数据寄存器
reg sda_link;	//输出数据sda信号inout方向控制位		
reg[3:0] num;	//

reg [7:0] tmp_data;

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		begin
			cstate <= IDLE;
			sda_r <= 1'b1;
			sda_link <= 1'b0;
			num <= 4'd0;
			tmp_data <= 8'b0000_0000;
			idle_state<=1'b0;
			clr_sw<=1'b0;
		end
	else 	  
		case (cstate)
			IDLE:	
				begin
				    clr_sw<=1'b0;
					sda_link <= 1'b1;			//数据线sda为input
					sda_r <= 1'b1;
					if(!sw1_r || !sw2_r) 
						begin//读写信号有一个有效		
						  db_r <= `DEVICE_WRITE;	//送器件地址（写操作）
						  cstate <= START1;	
						  idle_state<=1'b1;
						 // clr_sw<=1'b0;
						end
					else 
					   begin
					      cstate <= IDLE;	//任何读写信号无效
					   end
				end
			START1: 
				begin
					if(`SCL_HIG) 
					    begin//scl为高电平期间
						  sda_link <= 1'b1;	//数据线sda为output
						  sda_r <= 1'b0;	//拉低数据线sda，产生起始位信号
						  cstate <= ADD1;
						  num <= 4'd0;		//num计数清零
						end
					else 
					    cstate <= START1; //等待scl高电平中间位置到来
				end
			ADD1:	
				begin
					if(`SCL_LOW) 
						begin
							if(num == 4'd8) 
								begin	
									num <= 4'd0;			//num计数清零
									sda_r <= 1'b1;
									sda_link <= 1'b0;		//sda置为高阻态(input)
									cstate <= ACK1;
								end
							else 
								begin
									cstate <= ADD1;
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db_r[7];
										4'd1: sda_r <= db_r[6];
										4'd2: sda_r <= db_r[5];
										4'd3: sda_r <= db_r[4];
										4'd4: sda_r <= db_r[3];
										4'd5: sda_r <= db_r[2];
										4'd6: sda_r <= db_r[1];
										4'd7: sda_r <= db_r[0];
										default: ;
									endcase
								end
						end
					else 
					   cstate <= ADD1;
				end
			ACK1:	
				begin
					if(`SCL_NEG) 
						begin	//注：24C01/02/04/08/16器件可以不考虑应答位
							cstate <= ADD2;	//从机响应信号
						    db_r <= addr;	// 1地址		
						end
					else 
					   cstate <= ACK1;		//等待从机响应
				end
			ADD2:	
				begin
					if(`SCL_LOW) 
						begin
							if(num==4'd8) 
								begin	
									num <= 4'd0;			//num计数清零
									sda_r <= 1'b1;
									sda_link <= 1'b0;		//sda置为高阻态(input)
									cstate <= ACK2;
								end
							else 
								begin
									sda_link <= 1'b1;		//sda作为output
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db_r[7];
										4'd1: sda_r <= db_r[6];
										4'd2: sda_r <= db_r[5];
										4'd3: sda_r <= db_r[4];
										4'd4: sda_r <= db_r[3];
										4'd5: sda_r <= db_r[2];
										4'd6: sda_r <= db_r[1];
										4'd7: sda_r <= db_r[0];
										default: ;
									endcase		
									cstate <= ADD2;					
								end
						end
					else 
					    cstate <= ADD2;				
				end
			ACK2:	begin
					if(`SCL_NEG) 
						begin		//从机响应信号
						   if(!sw1_r) 
							  begin
								cstate <= DATA; 	//写操作	
								db_r <= write_data;	//写入的数据						
							  end	
						   else if(!sw2_r) 
							  begin
								db_r <= `DEVICE_READ;	//送器件地址（读操作），特定地址读需要执行该步骤以下操作
								cstate <= START2;		//读操作
							  end
						end
					else 
					   cstate <= ACK2;	//等待从机响应
				end
			START2: begin	//读操作起始位
					if(`SCL_LOW) 
						begin
						sda_link <= 1'b1;	//sda作为output
						sda_r <= 1'b1;		//拉高数据线sda
						cstate <= START2;
						end
					else if(`SCL_HIG) 
						begin	//scl为高电平中间
						sda_r <= 1'b0;		//拉低数据线sda，产生起始位信号
						cstate <= ADD3;
						end	 
					else 
					    cstate <= START2;
				end
			ADD3:	begin	//送读操作地址
					if(`SCL_LOW) begin
							if(num==4'd8) 
								begin	
									num <= 4'd0;			//num计数清零
									sda_r <= 1'b1;
									sda_link <= 1'b0;		//sda置为高阻态(input)
									cstate <= ACK3;
								end
							else begin
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db_r[7];
										4'd1: sda_r <= db_r[6];
										4'd2: sda_r <= db_r[5];
										4'd3: sda_r <= db_r[4];
										4'd4: sda_r <= db_r[3];
										4'd5: sda_r <= db_r[2];
										4'd6: sda_r <= db_r[1];
										4'd7: sda_r <= db_r[0];
										default: ;
									endcase											
									cstate <= ADD3;					
								end
						end
					else cstate <= ADD3;				
				end
			ACK3:	begin
					if(/*!sda*/`SCL_NEG) 
						begin
							cstate <= DATA;	//从机响应信号
							sda_link <= 1'b0;
						end
					else 
					   cstate <= ACK3; 		//等待从机响应
				end
			DATA:	begin
					if(!sw2_r) 
						begin	 //读操作
							if(num<=4'd7) 
								begin
								cstate <= DATA;
								if(`SCL_HIG) 
									begin	
									  num <= num+1'b1;	
									  case (num)
										4'd0: tmp_data[7] <= sda;
										4'd1: tmp_data[6] <= sda;  
										4'd2: tmp_data[5] <= sda; 
										4'd3: tmp_data[4] <= sda; 
										4'd4: tmp_data[3] <= sda; 
										4'd5: tmp_data[2] <= sda; 
										4'd6: tmp_data[1] <= sda; 
										4'd7: tmp_data[0] <= sda; 
										default: ;
									  endcase																		
									end
								end
							  else if((`SCL_LOW) && (num==4'd8)) 
								begin
								   num <= 4'd0;			//num计数清零
								   cstate <= ACK4;
								end
							  else 
							     cstate <= DATA;
						end
					else if(!sw1_r) begin	//写操作
							sda_link <= 1'b1;	
							if(num<=4'd7) begin
								cstate <= DATA;
								if(`SCL_LOW) begin
									sda_link <= 1'b1;		//数据线sda作为output
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db_r[7];
										4'd1: sda_r <= db_r[6];
										4'd2: sda_r <= db_r[5];
										4'd3: sda_r <= db_r[4];
										4'd4: sda_r <= db_r[3];
										4'd5: sda_r <= db_r[2];
										4'd6: sda_r <= db_r[1];
										4'd7: sda_r <= db_r[0];
										default: ;
										endcase	
									end
							 	end
							else if((`SCL_LOW) && (num==4'd8)) begin
									num <= 4'd0;
									sda_r <= 1'b1;
									sda_link <= 1'b0;		//sda置为高阻态
									cstate <= ACK4;
								end
							else cstate <= DATA;
						end
				end
			ACK4: begin
					if(/*!sda*/`SCL_NEG) begin
						cstate <= STOP1;	
						clr_sw<=1'b1;					
						end
					else cstate <= ACK4;
				end
			STOP1:	begin
					if(`SCL_LOW) begin
							sda_link <= 1'b1;
							sda_r <= 1'b0;
							cstate <= STOP1;
						end
					else if(`SCL_HIG) begin
							sda_r <= 1'b1;	//scl为高时，sda产生上升沿（结束信号）
							cstate <= STOP2;
						end
					else cstate <= STOP1;
				end
			STOP2:	begin
					if(`SCL_LOW) sda_r <= 1'b1;
					else if(cnt_20ms==20'h7fff0) 
					   begin
					     cstate <= IDLE;
					     idle_state<=1'b0;
					   end
					else 
					  cstate <= STOP2;
				end
			default: 
			   begin
				  cstate <= IDLE;
			   end
			endcase
end

assign sda = sda_link ? sda_r:1'bz;
assign read_data=idle_state?8'bzzzz_zzzz:tmp_data;	
//---------------------------------------------
endmodule


