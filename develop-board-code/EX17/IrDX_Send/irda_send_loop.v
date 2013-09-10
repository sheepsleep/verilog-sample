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

module irda_send_loop (
                  clk,
                  rst_n,
                  sw,
                  irda_send
                 );
  input   clk;  //50MHz clock
  input   rst_n; //复位信号，低电平有效
  input   [2:0]sw; //低电平有效

  output reg irda_send;//红外发射输出管脚

  reg [10:0] carrier_cnt;
  reg [22:0] clk_cnt_108; // 108 ms
  reg [18:0] clk_cnt_9;   // 9ms leader counter
  reg [17:0] clk_cnt_4;   // 9ms leader counter
  reg [15:0] clk_cnt_056; // 0.56ms data carrier counter
  reg [15:0] clk_cnt_0565;// 0.565ms data  counter
  reg [16:0] clk_cnt_169; // 1.69ms data counter
  reg  clear_cnt;
  reg  clear_cnt_flag;
  wire start;
  wire irda_start;
  wire irda_ready;
  
  reg [2:0]  cs,ns;
  reg leader_9_over;
  reg leader_4_over;
  reg data_state_over;
  reg carrier_ok;
  reg [5:0] data_cnt;

  parameter   IDLE       = 3'b000,
              LEADER_9   = 3'b001,
              LEADER_4   = 3'b010,
              DATA_STATE = 3'b100;
  
  wire [15:0] custom_code = {16'h1234};  // 16 bit custom code
  wire [15:0] data_code =   (sw[0] == 1'b0) ? {16'h1111} 
                          : (sw[1] == 1'b0) ? {16'h2222}
                          : (sw[2] == 1'b0) ? {16'h3333}
                       //   : (sw[3] == 1'b0) ? {16'h4444}
                       //   : (sw[4] == 1'b0) ? {16'h5555}
                       //   : (sw[5] == 1'b0) ? {16'h6666}
                       //   : (sw[6] == 1'b0) ? {16'h7777}
                       //   : (sw[7] == 1'b0) ? {16'h8888}
                          :  irda_ready   ? {16'h0000}    // 16 bit data code
                          :  data_code;
  wire [31:0] total_code = {custom_code,data_code};
                           
    
  //assign start = !(key1 || leader_9_over || leader_4_over || data_state_over);
  assign irda_ready = (clk_cnt_108 == 23'd5400000) ? 1'b1 : 1'b0;
  assign start = irda_ready & (!(sw[0]&sw[1]&sw[2]));
  assign irda_start = (start & irda_ready) ? 1'b1 : 1'b0;
    
  // 108ms leader counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_108 <= 23'd0;
    else if (irda_start)
      clk_cnt_108 <= 23'd0;
    else if (clk_cnt_108 == 23'd5400000) // 108ms/20ns = 5400,000
      clk_cnt_108 <= clk_cnt_108;
    else 
      clk_cnt_108 <= clk_cnt_108 + 1'b1;

  // 38KHz carrier high+low part    
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      carrier_cnt <= 11'd0;
    else if (clear_cnt)
      carrier_cnt <= 11'd0;
    else if (carrier_cnt == 11'd1315) // 26.3us/20ns = 1315
      carrier_cnt <= 11'd0;
    else
      carrier_cnt <= carrier_cnt + 1'b1;
      
  // 9ms leader counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_9 <= 19'd0;
    else if (clear_cnt)
      clk_cnt_9 <= 19'd0;
    else if (clk_cnt_9 == 19'd450000) // 9ms/20ns = 450,000
      clk_cnt_9 <= 19'd0;
    else 
      clk_cnt_9 <= clk_cnt_9 + 1'b1;
      
  // 4.5ms leader counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_4 <= 18'd0;
    else if (clear_cnt)
      clk_cnt_4 <= 18'd0;
    else if (clk_cnt_4 == 18'd225000) // 4.5ms/20ns = 225,000
      clk_cnt_4 <= 18'd0;
    else 
      clk_cnt_4 <= clk_cnt_4 + 1'b1;
      
  // 0.56ms data carrier counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_056 <= 16'd0;
    else if (clear_cnt)
      clk_cnt_056 <= 16'd0;
    else if (clk_cnt_056 == 16'd28000) // 0.56ms/20ns = 28,000
      clk_cnt_056 <= 16'd0;
    else 
      clk_cnt_056 <= clk_cnt_056 + 1'b1;
      
  // (1.125ms - 0.56ms =0.565ms) 0.565ms data  counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_0565 <= 16'd0;
    else if (clear_cnt)
      clk_cnt_0565 <= 16'd0;
    else if (clk_cnt_0565 == 16'd28250) // 0.565ms/20ns = 28,250
      clk_cnt_0565 <= 16'd0;
    else 
      clk_cnt_0565 <= clk_cnt_0565 + 1'b1;
      
  // (2.25ms - 0.56ms = 1.69ms) 1.69ms data counter
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      clk_cnt_169 <= 17'd0;
    else if (clear_cnt)
      clk_cnt_169 <= 17'd0;
    else if (clk_cnt_169 == 17'd84500) // 1.69ms/20ns = 84,500
      clk_cnt_169 <= 17'd0;
    else 
      clk_cnt_169 <= clk_cnt_169 + 1'b1;
      
  //----------------------------------------------------------------------------
  // generate statemachine
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      cs <= IDLE;
    else 
      cs <= ns;
      
  always @ ( * )
    case (cs)
      IDLE: 
        if (start) 
          ns = LEADER_9;
        else
          ns = IDLE;
      LEADER_9:
        if (leader_9_over)   //leader 9ms check
          ns = LEADER_4;
        else   //完备的if---else--- ；防止生成latch
          ns =LEADER_9;
      LEADER_4:
        if (leader_4_over)  // leader 4.5ms check
          ns = DATA_STATE;
        else
          ns = LEADER_4;
      DATA_STATE:
        if (data_state_over)
          ns = IDLE;
        else
          ns = DATA_STATE;
      default:
        ns = IDLE;
    endcase

  //状态机中的输出，用时序电路来描述
  always @ (posedge clk or negedge rst_n)
  if (!rst_n)
    begin
      leader_9_over <= 1'b0;
      leader_4_over <= 1'b0;
      data_state_over <= 1'b0;
      clear_cnt <= 1'b0;
      clear_cnt_flag <= 1'b0;
      carrier_ok <= 1'b0;
      data_cnt <= 6'd0;
      irda_send <= 1'b0;
    end
  else if (cs == IDLE)
    begin
      leader_9_over <= 1'b0;
      leader_4_over <= 1'b0;
      data_state_over <= 1'b0;
      clear_cnt <= 1'b0;
      clear_cnt_flag <= 1'b0;
      carrier_ok <= 1'b0;
      data_cnt <= 6'd0;
      irda_send <= 1'b0;
    end
  else if (cs == LEADER_9)
    begin
      if (clear_cnt_flag == 1'b0)
        begin
          clear_cnt <= 1'b1;  //clear all counter
          clear_cnt_flag <= 1'b1;
        end
      else 
        begin
          clear_cnt <= 1'b0;
          if (clk_cnt_9 == 19'd450000) // 9ms/20ns = 450,000
            begin
              leader_9_over <= 1'b1;
              clear_cnt_flag <= 1'b0;
              irda_send <= 1'b0;
            end
          else if ((11'd0 <= carrier_cnt) && (carrier_cnt <= 11'd438))  // 8.77us/20ns = 438.5
            irda_send <= 1'b1;  // 8.77us carrier high part
          else 
            irda_send <= 1'b0; //26.3us- 8.77us carrier low part
        end
    end
  else if (cs == LEADER_4)
    begin
      if (clear_cnt_flag == 1'b0)
        begin
          clear_cnt <= 1'b1;  //clear all counter
          clear_cnt_flag <= 1'b1;
          leader_9_over <= 1'b0; // clear flag
        end
      else 
        begin
          clear_cnt <= 1'b0;
          if (clk_cnt_4 == 18'd225000) // 4.5ms/20ns = 225,000
            begin
              leader_4_over <= 1'b1;
              clear_cnt_flag <= 1'b0;
              irda_send <= 1'b0;
            end
          else 
            irda_send <= 1'b0; // 4.5ms low part
        end
    end
  else if (cs == DATA_STATE)
    begin
      leader_4_over <= 1'b0; // clear flag
      if (data_cnt < 32)
        begin
          if (carrier_ok == 0)  //first send 0.56ms carrier
            begin
              if (clear_cnt_flag == 1'b0)
                begin
                  clear_cnt <= 1'b1;  //clear all counter
                  clear_cnt_flag <= 1'b1;
                end
              else
                begin
                  clear_cnt <= 1'b0;
                  if (clk_cnt_056 == 16'd28000) // 0.56ms/20ns = 28,000
                    begin
                      carrier_ok <= 1'b1;
                      clear_cnt_flag <= 1'b0;
                      irda_send <= 1'b0;
                    end
                  else if ((11'd0 <= carrier_cnt) && (carrier_cnt <= 11'd438))  // 8.77us/20ns = 438.5
                    irda_send <= 1'b1;  // 8.77us carrier high part)
                  else 
                    irda_send <= 1'b0;  //26.3us- 8.77us carrier low part
                end 
            end
          else         //then send low data 
            begin
              if (total_code[31 - data_cnt])  //data = 1
                begin
                  if (clear_cnt_flag == 1'b0)
                    begin
                      clear_cnt <= 1'b1;  //clear all counter
                      clear_cnt_flag <= 1'b1;
                    end
                  else
                    begin
                      clear_cnt <= 1'b0;
                      if (clk_cnt_169 == 17'd84500) // 1.69ms/20ns = 84,500
                        begin
                          carrier_ok <= 1'b0;
                          clear_cnt_flag <= 1'b0;
                          irda_send <= 1'b0;
                          data_cnt <= data_cnt + 1'b1;
                        end
                      else 
                        irda_send <= 1'b0;
                    end
                end
              else   // data = 0
                begin
                  if (clear_cnt_flag == 1'b0)
                    begin
                      clear_cnt <= 1'b1;  //clear all counter
                      clear_cnt_flag <= 1'b1;
                    end
                  else
                    begin
                      clear_cnt <= 1'b0;
                      if (clk_cnt_0565 == 16'd28250) // 0.565ms/20ns = 28,250
                        begin
                          carrier_ok <= 1'b0;
                          clear_cnt_flag <= 1'b0;
                          irda_send <= 1'b0;
                          data_cnt <= data_cnt + 1'b1;
                        end
                      else 
                        irda_send <= 1'b0;
                    end
                end 
            end
        end
      else
        begin
          if (clear_cnt_flag == 1'b0)
            begin
              clear_cnt <= 1'b1;  //clear all counter
              clear_cnt_flag <= 1'b1;
            end
          else
            begin
              clear_cnt <= 1'b0;
              if (clk_cnt_056 == 16'd28000) // 0.56ms/20ns = 28,000
                begin
                  carrier_ok <= 1'b1;
                  clear_cnt_flag <= 1'b0;
                  data_state_over <= 1'b1;
                  irda_send <= 1'b0;
                end
              else if ((11'd0 <= carrier_cnt) && (carrier_cnt <= 11'd438))  // 8.77us/20ns = 438.5
                irda_send <= 1'b1;  // 8.77us carrier high part)
              else 
                irda_send <= 1'b0;  //26.3us- 8.77us carrier low part
            end 
        end
      end
    

endmodule