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

  // ---------------------------------------------------------------------------
  //HC164用来驱动数码管以及LED指示灯，动态扫描数码管的是利用视觉暂留的特性进行显
  //示景物引起人的视觉印象，在景物消失后还能在视网膜上保持0。1秒的时间叫做视觉暂
  //留。可以将数据刷新速率可以为10Hz(0.1s)，同时我们需要对四位数据进行扫描，因此
  //数据刷新速率最低应该为10Hz×4。最高可以为50MHz(HC164可以工作在50－175MHz)。
  //根据实际情况我们可以定为 762.939453125 = 50MHz/2**16,
  //因此接口处led,seg_value,dot数据的变化速率最大不能超过为50MHz/2**14
  // ---------------------------------------------------------------------------

module hc164_driver(
    clk,
    rst_n,
    dot,
    seg_value,
    hc_cp,
    hc_si
    );

  // ---------------------------------------------------------------------------
  //
  //  input signals
  //  seg_value[15:0] :8位共阳极数码显示的数据，从高到低每4bit为数码管一位。
  //  dot[7:0] :       8位共阳极数码管显示的小数点位，从高到低
  //  hc_si :          本模块数据串行输出，hc164数据串行输入。
  //  hc_cp :          本模块输出，hc164时钟输入。
  //  
  // ---------------------------------------------------------------------------
  input           clk;
  input           rst_n;   
  input   [7 :0]  dot;       
  input   [31:0]  seg_value; 
  output  reg     hc_cp;                //HC164 Clock input active Rising edges
  output          hc_si;                //HC164 Data input

  reg     [5 :0]  tx_cnt;
 
  // ---------------------------------------------------------------------------
  //
  //  信号命名说明
  //  hc_data : 送到两个hc164中16bit的数据（每个hc164有8bit），hc164 data input
  //  hc_data_H8bit: hc_data的的8位位码数据，
  //                 对应原理图中HC_Q15,HC_Q14,HC_Q13,HC_Q12,HC_Q11,HC_Q10,HC_Q9,
  //                 HC_Q8数码管位选信号，高电平有效。
  //  hc_data_Dpbit: hc_data的第7位数据，即hc_data[7];对应原理图中HC_Q7，数
  //                 码管小数点位，低电平有效。 
  //  hc_data[6:0]: 这7bit用来做为数码管段选信号，高电平有效
  //
  // ---------------------------------------------------------------------------
  reg   [6:0]   hex2led;        //hex-to-seven-segment decoder output 
  reg   [7:0]   hc_data_H8bit;  
  reg           hc_data_Dpbit;    
  
  wire  [15:0]  hc_data = {hc_data_H8bit,
                          hc_data_Dpbit,
                          hex2led[6:0]
                          };
  // ---------------------------------------------------------------------------
  //
  //  之所以需要取反，是因为对hc_si赋值时从最低位开始,而原理图中设计希望从最高位
  //  开始发送数据。
  //
  // ---------------------------------------------------------------------------
  wire  [15:0]  hc_data_inv = {
                          hc_data[0],
                          hc_data[1],
                          hc_data[2],
                          hc_data[3],
                          hc_data[4],
                          hc_data[5],
                          hc_data[6],
                          hc_data[7],
                          hc_data[8],
                          hc_data[9],
                          hc_data[10],
                          hc_data[11],
                          hc_data[12],
                          hc_data[13],
                          hc_data[14],
                          hc_data[15]
                          };

  reg [15:0]  clk_cnt;
  always @ ( posedge clk or negedge rst_n )
    if ( !rst_n ) clk_cnt <= 16'd0;
    else  clk_cnt <= clk_cnt + 1'b1;
      
  // ---------------------------------------------------------------------------
  // 
  //  数据管4位计数器，本计数器用来区分每位数值，位码，以及每位的小数点等三个
  //  信息，每一位数值将通过hex2led模块变换成数码管位码。
  //
  // ---------------------------------------------------------------------------
  reg [2:0] seg_led_num;
  always @ ( posedge clk or negedge rst_n )
    if (!rst_n ) seg_led_num <= 3'b000;
    else if ( clk_cnt == 16'hFFFF ) seg_led_num <= seg_led_num + 1'b1;

  reg   [3:0] hex;
  always @ ( * )
    case ( seg_led_num )
      3'b000: hex = seg_value[31:28];
      3'b001: hex = seg_value[27:24];
      3'b010: hex = seg_value[23:20];
      3'b011: hex = seg_value[19:16];
      3'b100: hex = seg_value[15:12];
      3'b101: hex = seg_value[11:8];
      3'b110: hex = seg_value[7:4];
      3'b111: hex = seg_value[3:0];
    endcase 
  
  // ---------------------------------------------------------------------------
  // hex-to-seven-segment decoder
  //
  // segment encoding
  //      0
  //      ---  
  //  5  |   | 1
  //      ---   <- 6
  //  4  |   | 2
  //      --- .  7
  //       3 
  //  Q[7:0] = p7 - p0 
  // ---------------------------------------------------------------------------
  always @ ( * )
    begin
      case (hex)                        //数值 
	      4'h1  : hex2led = 7'b1111_001;	//1          
	      4'h2  : hex2led = 7'b0100_100;	//2   
	      4'h3  : hex2led = 7'b0110_000;	//3   
	      4'h4  : hex2led = 7'b0011_001;	//4   
	      4'h5  : hex2led = 7'b0010_010;	//5   
	      4'h6  : hex2led = 7'b0000_010;	//6   
	      4'h7  : hex2led = 7'b1111_000;	//7   
	      4'h8  : hex2led = 7'b0000_000;	//8   
	      4'h9  : hex2led = 7'b0011_000;	//9   
	      4'hA  : hex2led = 7'b0001_000;	//A   
	      4'hB  : hex2led = 7'b0000_011;	//b   
	      4'hC  : hex2led = 7'b1000_110;	//C   
	      4'hD  : hex2led = 7'b0100_001;	//d   
	      4'hE  : hex2led = 7'b0000_110;	//E   
	      4'hF  : hex2led = 7'b0001_110;	//F   
	    default : hex2led = 7'b1000_000;	//0   
    endcase
  end
 
  always @ ( * )
    case ( seg_led_num )
      3'b000:hc_data_H8bit[7:0] = 8'b10000000;
      3'b001:hc_data_H8bit[7:0] = 8'b01000000;
      3'b010:hc_data_H8bit[7:0] = 8'b00100000;
      3'b011:hc_data_H8bit[7:0] = 8'b00010000;
      3'b100:hc_data_H8bit[7:0] = 8'b00001000;
      3'b101:hc_data_H8bit[7:0] = 8'b00000100;
      3'b110:hc_data_H8bit[7:0] = 8'b00000010;
      3'b111:hc_data_H8bit[7:0] = 8'b00000001;
    endcase  

  always @ ( * )
    case ( seg_led_num )
      3'b000:hc_data_Dpbit = dot[7];
      3'b001:hc_data_Dpbit = dot[6];
      3'b010:hc_data_Dpbit = dot[5];
      3'b011:hc_data_Dpbit = dot[4];
      3'b100:hc_data_Dpbit = dot[3];
      3'b101:hc_data_Dpbit = dot[2];
      3'b110:hc_data_Dpbit = dot[1];
      3'b111:hc_data_Dpbit = dot[0];
    endcase  
  
  // ---------------------------------------------------------------------------
  // 
  // HC164 的 hc_si 以及hc_cp信号的产生，通过一个6位的计数器来控制.hc_si从信号
  // hc_data_inv的最低位开始发送，原理图中需要从最高位发送，因此在此之前需要对整
  // 个信号取反。
  //
  // ---------------------------------------------------------------------------  
  always @ ( posedge clk or negedge rst_n )
    if (!rst_n ) tx_cnt <= 6'd0;
    else if ( clk_cnt[15] ) tx_cnt <= 6'd0;      
    else if ((!clk_cnt[15]) && (tx_cnt <= 6'd32 )) tx_cnt <= tx_cnt + 1'b1;

  always @ ( posedge clk or negedge rst_n )
    if (!rst_n)  hc_cp <= 1'b0;
    else if ( clk_cnt[15] ) hc_cp <= 1'b0;
    else if ((!clk_cnt[15]) && (tx_cnt < 6'd32 )) hc_cp <= !hc_cp;

  assign  hc_si = hc_data_inv[tx_cnt[4:1]];
    
endmodule