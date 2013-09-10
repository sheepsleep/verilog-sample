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
module LCD_Driver(
  input              clk,               // 50MHz时钟
  input              rst_n,             // 复位信号
  // LCD1602 Interface
  output reg [  7:0] lcd_data,          // 数据总线
  output             lcd_e,             // 使能信号
  output reg         lcd_rs,            // 指令、数据选择
  output             lcd_rw             // 读、写选择
);  

// +++++++++++++++++++++++++++++++++++++
// 分频模块 开始
// +++++++++++++++++++++++++++++++++++++
reg [15:0] cnt;                         // 计数子

always @ (posedge clk, negedge rst_n)
  if (!rst_n) 
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;

// 500Khz ~ 1MHz 皆可
wire lcd_clk = cnt[15];       // (2^16 / 50M) = 1.31ms                                   
// -------------------------------------
// 分频模块 结束
// -------------------------------------


// +++++++++++++++++++++++++++++++++++++
// LCD1602驱动模块 开始
// +++++++++++++++++++++++++++++++++++++
// 格雷码编码：共40个状态
parameter IDLE         = 8'h00;
// 写指令，初始化
parameter DISP_SET     = 8'h01;         // 显示模式设置
parameter DISP_OFF     = 8'h03;         // 显示关闭
parameter CLR_SCR      = 8'h02;         // 显示清屏
parameter CURSOR_SET1  = 8'h06;         // 显示光标移动设置
parameter CURSOR_SET2  = 8'h07;         // 显示开及光标设置
// 显示第一行
parameter ROW1_ADDR    = 8'h05;         // 写第1行起始地址
parameter ROW1_0       = 8'h04;
parameter ROW1_1       = 8'h0C;
parameter ROW1_2       = 8'h0D;
parameter ROW1_3       = 8'h0F;
parameter ROW1_4       = 8'h0E;
parameter ROW1_5       = 8'h0A;
parameter ROW1_6       = 8'h0B;
parameter ROW1_7       = 8'h09;
parameter ROW1_8       = 8'h08;
parameter ROW1_9       = 8'h18;
parameter ROW1_A       = 8'h19;
parameter ROW1_B       = 8'h1B;
parameter ROW1_C       = 8'h1A;
parameter ROW1_D       = 8'h1E;
parameter ROW1_E       = 8'h1F;
parameter ROW1_F       = 8'h1D;
// 显示第二行
parameter ROW2_ADDR    = 8'h1C;         // 写第2行起始地址
parameter ROW2_0       = 8'h14;
parameter ROW2_1       = 8'h15;
parameter ROW2_2       = 8'h17;
parameter ROW2_3       = 8'h16;
parameter ROW2_4       = 8'h12;
parameter ROW2_5       = 8'h13;
parameter ROW2_6       = 8'h11;
parameter ROW2_7       = 8'h10;
parameter ROW2_8       = 8'h30;
parameter ROW2_9       = 8'h31;
parameter ROW2_A       = 8'h33;
parameter ROW2_B       = 8'h32;
parameter ROW2_C       = 8'h36;
parameter ROW2_D       = 8'h37;
parameter ROW2_E       = 8'h35;
parameter ROW2_F       = 8'h34;

reg [5:0] current_state, next_state;    // 现态、次态

// FSM: always1
always @ (posedge lcd_clk, negedge rst_n)
  if(!rst_n)  current_state <= IDLE;
  else        current_state <= next_state;

// FSM: always2
always
begin
  case(current_state)
    IDLE        : next_state = DISP_SET;
    // 写指令，初始化
    DISP_SET    : next_state = DISP_OFF;
    DISP_OFF    : next_state = CLR_SCR;
    CLR_SCR     : next_state = CURSOR_SET1;
    CURSOR_SET1 : next_state = CURSOR_SET2;
    CURSOR_SET2 : next_state = ROW1_ADDR;
    // 显示第一行
    ROW1_ADDR   : next_state = ROW1_0;
    ROW1_0      : next_state = ROW1_1;
    ROW1_1      : next_state = ROW1_2;
    ROW1_2      : next_state = ROW1_3;
    ROW1_3      : next_state = ROW1_4;
    ROW1_4      : next_state = ROW1_5;
    ROW1_5      : next_state = ROW1_6;
    ROW1_6      : next_state = ROW1_7;
    ROW1_7      : next_state = ROW1_8;
    ROW1_8      : next_state = ROW1_9;
    ROW1_9      : next_state = ROW1_A;
    ROW1_A      : next_state = ROW1_B;
    ROW1_B      : next_state = ROW1_C;
    ROW1_C      : next_state = ROW1_D;
    ROW1_D      : next_state = ROW1_E;
    ROW1_E      : next_state = ROW1_F;
    ROW1_F      : next_state = ROW2_ADDR;
    // 显示第二行
    ROW2_ADDR   : next_state = ROW2_0; 
    ROW2_0      : next_state = ROW2_1;
    ROW2_1      : next_state = ROW2_2;
    ROW2_2      : next_state = ROW2_3;
    ROW2_3      : next_state = ROW2_4;
    ROW2_4      : next_state = ROW2_5;
    ROW2_5      : next_state = ROW2_6;
    ROW2_6      : next_state = ROW2_7;
    ROW2_7      : next_state = ROW2_8;
    ROW2_8      : next_state = ROW2_9;
    ROW2_9      : next_state = ROW2_A;
    ROW2_A      : next_state = ROW2_B;
    ROW2_B      : next_state = ROW2_C;
    ROW2_C      : next_state = ROW2_D;
    ROW2_D      : next_state = ROW2_E;
    ROW2_E      : next_state = ROW2_F;
    ROW2_F      : next_state = ROW1_ADDR;
    //
    default     : next_state = IDLE ;
  endcase
end

// FSM: always3
always @ (posedge lcd_clk, negedge rst_n)
begin
  if(!rst_n)
  begin 
    lcd_rs   <= 0; 
    lcd_data <= 8'hxx; 
  end
  else
  begin 
    // 写lcd_rs
    case(next_state)      
      IDLE        : lcd_rs <= 0;
      // 写指令，初始化
      DISP_SET    : lcd_rs <= 0;
      DISP_OFF    : lcd_rs <= 0;
      CLR_SCR     : lcd_rs <= 0;
      CURSOR_SET1 : lcd_rs <= 0;
      CURSOR_SET2 : lcd_rs <= 0;
      // 写数据，显示第一行
      ROW1_ADDR   : lcd_rs <= 0;
      ROW1_0      : lcd_rs <= 1;
      ROW1_1      : lcd_rs <= 1;
      ROW1_2      : lcd_rs <= 1;
      ROW1_3      : lcd_rs <= 1;
      ROW1_4      : lcd_rs <= 1;
      ROW1_5      : lcd_rs <= 1;
      ROW1_6      : lcd_rs <= 1;
      ROW1_7      : lcd_rs <= 1;
      ROW1_8      : lcd_rs <= 1;
      ROW1_9      : lcd_rs <= 1;
      ROW1_A      : lcd_rs <= 1;
      ROW1_B      : lcd_rs <= 1;
      ROW1_C      : lcd_rs <= 1;
      ROW1_D      : lcd_rs <= 1; 
      ROW1_E      : lcd_rs <= 1;
      ROW1_F      : lcd_rs <= 1;
      // 写数据，显示第二行
      ROW2_ADDR   : lcd_rs <= 0;
      ROW2_0      : lcd_rs <= 1;
      ROW2_1      : lcd_rs <= 1;
      ROW2_2      : lcd_rs <= 1;
      ROW2_3      : lcd_rs <= 1;
      ROW2_4      : lcd_rs <= 1;
      ROW2_5      : lcd_rs <= 1;
      ROW2_6      : lcd_rs <= 1;
      ROW2_7      : lcd_rs <= 1;
      ROW2_8      : lcd_rs <= 1;
      ROW2_9      : lcd_rs <= 1;
      ROW2_A      : lcd_rs <= 1;
      ROW2_B      : lcd_rs <= 1;
      ROW2_C      : lcd_rs <= 1;
      ROW2_D      : lcd_rs <= 1; 
      ROW2_E      : lcd_rs <= 1;
      ROW2_F      : lcd_rs <= 1;
    endcase    
    
    // 写lcd_data
    case(next_state)
      IDLE        : lcd_data <= 8'hxx;
      // 写指令，初始化
      DISP_SET    : lcd_data <= 8'h38;
      DISP_OFF    : lcd_data <= 8'h08;
      CLR_SCR     : lcd_data <= 8'h01;
      CURSOR_SET1 : lcd_data <= 8'h06;
      CURSOR_SET2 : lcd_data <= 8'h0C;
      // 写数据，显示第一行
      ROW1_ADDR   : lcd_data <= 8'h80;
      ROW1_0      : lcd_data <= "H";
      ROW1_1      : lcd_data <= "e";
      ROW1_2      : lcd_data <= "l";
      ROW1_3      : lcd_data <= "l";
      ROW1_4      : lcd_data <= "o";
      ROW1_5      : lcd_data <= " ";
      ROW1_6      : lcd_data <= "F";
      ROW1_7      : lcd_data <= "P";
      ROW1_8      : lcd_data <= "G";
      ROW1_9      : lcd_data <= "A";
      ROW1_A      : lcd_data <= " ";
      ROW1_B      : lcd_data <= "W";
      ROW1_C      : lcd_data <= "o";
      ROW1_D      : lcd_data <= "r"; 
      ROW1_E      : lcd_data <= "l";
      ROW1_F      : lcd_data <= "d";
      // 写数据，显示第二行
      ROW2_ADDR   : lcd_data <= 8'hC0;
      ROW2_0      : lcd_data <= "Y";
      ROW2_1      : lcd_data <= "o";
      ROW2_2      : lcd_data <= "u";
      ROW2_3      : lcd_data <= "Z";
      ROW2_4      : lcd_data <= "h";
      ROW2_5      : lcd_data <= "i";
      ROW2_6      : lcd_data <= "y";
      ROW2_7      : lcd_data <= "u";
      ROW2_8      : lcd_data <= " ";
      ROW2_9      : lcd_data <= "1";
      ROW2_A      : lcd_data <= "1";
      ROW2_B      : lcd_data <= ".";
      ROW2_C      : lcd_data <= "9";
      ROW2_D      : lcd_data <= ".";
      ROW2_E      : lcd_data <= "1";
      ROW2_F      : lcd_data <= "0";
    endcase  
  end
end

assign lcd_e  = lcd_clk;       // 数据在时钟高电平被锁存                 
assign lcd_rw = 1'b0;          // 只写
// -------------------------------------
// LCD1602驱动模块 结束
// -------------------------------------

endmodule
