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

module vga_IC(
                  clk,
                  rst_n, 
                  vga_hs, 
                  vga_vs, 
                  vga_r0,  
                  vga_g0, 
                  vga_b0 
                  );

input 	clk;
input   rst_n ;// synthesis attribute clock_buffer of rst_n is ibufg;
output 	vga_hs;
output  vga_vs; // sync signals for monitor
output 	vga_r0, vga_g0, vga_b0;

wire            hsync;
wire            vsync;
wire            valid;        
wire    [9:0]   x_cnt;
wire    [9:0]   y_cnt;

wire    [9:0]   char_sel;
wire    [15:0]  char;

//设定屏幕分辨率：800x600      
wire    [9:0]   xpos;//[0...799]
wire    [9:0]   ypos;//[0...599]
reg     color;
assign  xpos = x_cnt - 10'd180;  //确定X轴像素位置
assign  ypos = y_cnt - 10'd35;   //确定Y轴像素位置     
                

sync_gen_50m sync_gen_50m_int (
    .clk     ( clk   ),
    .rst_n   ( rst_n ),
    .hsync   ( hsync ),
    .vsync   ( vsync ),
    .valid   ( valid ),
    .x_cnt   ( x_cnt ),
    .y_cnt   ( y_cnt )
    );        
        
wire    table0 = (( ypos > 10'd140 && ypos < 10'd460 )&&( xpos > 10'd160 && xpos < 10'd640 ));

wire    line0 = (( ypos == 10'd140 || ypos == 10'd460 ) && ( xpos > 10'd160 && xpos < 10'd640 )||
                 ( xpos == 10'd160 || xpos == 10'd640 ) && ( ypos > 10'd140 && ypos < 10'd460 ));

wire    word0 = ((xpos > 10'd204) && (xpos < 10'd588) &&
                 (ypos > 10'd96) && (ypos < 10'd128));
wire    word = word0 && color;

assign vga_r0 = valid ? (word ? 1'b1 : (line0 ? 1'b1 : (table0? 1'b0 : 1'b0 ))) : 1'b0;
assign vga_g0 = valid ? (word ? 1'b0 : (line0 ? 1'b1 : (table0? 1'b0 : 1'b0 ))) : 1'b0;
assign vga_b0 = valid ? (word ? 1'b0 : (line0 ? 1'b1 : (table0? 1'b0 : 1'b1 ))) : 1'b0;

assign  vga_hs = hsync;
assign  vga_vs = vsync;

assign  char_sel = xpos -10'd204;

  char_rom char_rom_inst(
    .addr   ({char_sel[9:5],ypos[4:1]}),  //字符的Y轴由16 pixel变为32 pixel
    .data   (char)            
    );
  
  always @(char_sel[4:1] or char)
    begin  	
	    case (char_sel[4:1])
	      4'h0 : color = char[15];   //将X轴对应点赋给color
	      4'h1 : color = char[14];
	      4'h2 : color = char[13];
	      4'h3 : color = char[12];
	      4'h4 : color = char[11];
	      4'h5 : color = char[10];
	      4'h6 : color = char[9];
	      4'h7 : color = char[8];	 	      	 	      
	      4'h8 : color = char[7];
	      4'h9 : color = char[6];
	      4'hA : color = char[5];
	      4'hB : color = char[4];
	      4'hC : color = char[3];
	      4'hD : color = char[2];
	      4'hE : color = char[1];
	      4'hF : color = char[0];	 	      	 	      
	    endcase
    end  
endmodule
