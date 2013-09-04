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
`timescale 1ns/1ns

module irda_check (clk, rst_n, irda, irda_data);
  input   clk;//50MHz clock
  input   rst_n;//复位信号，低电平有效
  input   irda;   //红外接收管脚
  output  irda_data;//接收数据的输出
  
  reg [15:0] irda_data;    // save irda data,than send to 7 segment led
  reg [31:0] get_data;     // use for saving 32 bytes irda data
  reg [5:0]  data_cnt;     // 32 bytes irda data counter
  reg [2:0]  cs,ns;
  reg error_flag;          // 32 bytes data期间，数据错误标志

  parameter   IDLE       = 3'b000,
              LEADER_9   = 3'b001,
              LEADER_4   = 3'b010,
              DATA_STATE = 3'b100;

  //----------------------------------------------------------------------------
  reg irda_reg0;       //为了避免亚稳态,避免驱动多个寄存器，这一个不使用。
  reg irda_reg1;       //这个才可以使用，以下程序中代表irda的状态
  reg irda_reg2; //为了确定irda的边沿，再打一次寄存器，以下程序中代表irda的前一状态
  wire irda_neg_pulse; //确定irda的下降沿
  wire irda_pos_pulse; //确定irda的上升沿
  wire irda_chang;     //确定irda的跳变沿
    
  always @ (posedge clk) //在此采用跟随寄存器
    if(!rst_n)
      begin
        irda_reg0 <= 1'b0;
        irda_reg1 <= 1'b0;
        irda_reg2 <= 1'b0;
      end
    else
      begin
        irda_reg0 <= irda;
        irda_reg1 <= irda_reg0;
        irda_reg2 <= irda_reg1;
      end 
      
  assign irda_chang = irda_neg_pulse | irda_pos_pulse;
  assign irda_neg_pulse = irda_reg2 & (~irda_reg1);
  assign irda_pos_pulse = (~irda_reg2) & irda_reg1;

  //----------------------------------------------------------------------------
  //设计分频和计数部分：从PT2222的规范中我们发现最小的电平保持时间是0.56ms，而
  //我们在进行采样时，一般都会对最小的电平采样16次。也就是说要对0.56ms最少采样16
  //次。
  //              0.56ms/16=35us 
  //在开发板上自带的主频为50MHz，即时钟周期为20ns，所以我们需要的分频次数为：
  //              35000/20=1750
  //在设计中我们利用了两个counter，一个counter用于计1750次时钟主频；
  //一个counter用于计算分频之后，同一种电平所scan到的点数，这个点数最后会用来判断
  //是leader的9ms 还是4.5ms，或是数据的 0 还是 1。
  //----------------------------------------------------------------------------
  reg [10:0] counter;  //分频1750次
  reg [8:0]  counter2; //计数分频后的点数
  wire check_9ms;  // check leader 9ms time
  wire check_4ms;  // check leader 4.5ms time
  wire low;        // check  data=0 time
  wire high;       // check  data=1 time
  
  always @ (posedge clk)
    if (!rst_n)
      counter <= 11'd0;
    else if (irda_chang)  //irda电平跳变了，就重新开始计数
      counter <= 11'd0;
    else if (counter == 11'd1750)
      counter <= 11'd0;
    else
      counter <= counter + 1'b1;
   
  always @ (posedge clk)
    if (!rst_n)
      counter2 <= 9'd0;
    else if (irda_chang)  //irda电平跳变了，就重新开始计点
      counter2 <= 9'd0;
    else if (counter == 11'd1750)
      counter2 <= counter2 +1'b1;

  assign check_9ms = ((217 < counter2) & (counter2 < 297)); //257
  assign check_4ms = ((88 < counter2) & (counter2 < 168));  //128
  assign low  = ((6 < counter2) & (counter2 < 26));         // 16
  assign high = ((38 < counter2) & (counter2 < 58));        // 48

  //----------------------------------------------------------------------------
  // generate statemachine
  always @ (posedge clk)
    if (!rst_n)
      cs <= IDLE;
    else 
      cs <= ns;
      
  always @ ( * )
    case (cs)
      IDLE: 
        if (~irda_reg1) 
          ns = LEADER_9;
        else
          ns = IDLE;
      LEADER_9:
        if (irda_pos_pulse)   //leader 9ms check
          begin
            if (check_9ms)
              ns = LEADER_4;
            else
              ns = IDLE;
          end
        else  //完备的if---else--- ;防止生成latch
          ns =LEADER_9;
      LEADER_4:
        if (irda_neg_pulse)  // leader 4.5ms check
          begin
            if (check_4ms)
              ns = DATA_STATE;
            else
              ns = IDLE;
          end
        else
          ns = LEADER_4;
      DATA_STATE:
        if ((data_cnt == 6'd32) & irda_reg2 & irda_reg1)
          ns = IDLE;
        else if (error_flag)
          ns = IDLE;
        else
          ns = DATA_STATE;
      default:
        ns = IDLE;
    endcase

  //状态机中的输出,用时序电路来描述
  always @ (posedge clk)
    if (!rst_n)
      begin
        data_cnt <= 6'd0;
        get_data <= 32'd0;
        error_flag <= 1'b0;
      end
    else if (cs == IDLE)
      begin
        data_cnt <= 6'd0;
        get_data <= 32'd0;
        error_flag <= 1'b0;
      end
    else if (cs == DATA_STATE)
      begin
        if (irda_pos_pulse)  // low 0.56ms check
          begin
            if (!low)  //error
              error_flag <= 1'b1;
          end
        else if (irda_neg_pulse)  //check 0.56ms/1.68ms data 0/1
          begin
            if (low)
              get_data[0] <= 1'b0;
            else if (high)
              get_data[0] <= 1'b1;
            else
              error_flag <= 1'b1;
              
            get_data[31:1] <= get_data[30:0];
            data_cnt <= data_cnt + 1'b1;
          end
      end

  always @ (posedge clk)
    if (!rst_n)
      irda_data <= 16'd0;
    else if ((data_cnt ==6'd32) & irda_reg1)
      irda_data <= get_data[15:0];
    
endmodule