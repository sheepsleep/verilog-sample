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

module segment(
    clk,
    rst_n,
    sw0,
    sw1,
    sw2,
    sw3,
    sw4,
    sw5,
    sw6,
    sw7,
    //output
    hc_cp,
    hc_si
    );
    
  input   clk;
  input   rst_n;
  input   sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7; //Active high
  output  hc_cp;
  output  hc_si;
  
  reg [31:0]data;
  reg [7:0]data_dot;
 //---------------------------------- 
  always @ (negedge rst_n)
    if (!rst_n)
      data_dot <= 8'h00;
 //---------------------------------- 
  always @ (posedge clk or negedge rst_n)
    if (!rst_n)
      data <= 32'h01234567;
    else if (sw0 == 1'b1)
      data <= 32'h12345678;
    else if (sw1 == 1'b1)
      data <= 32'h23456789;
    else if (sw2 == 1'b1)
      data <= 32'h3456789A;
    else if (sw3 == 1'b1)
      data <= 32'h456789AB;
    else if (sw4 == 1'b1)
      data <= 32'h56789ABC;
    else if (sw5 == 1'b1)
      data <= 32'h6789ABCD;
    else if (sw6 == 1'b1)
      data <= 32'h789ABCDE;
    else if (sw7 == 1'b1)
      data <= 32'h89ABCDEF;
          
  // ---------------------------------------------------------------------------
  // 例化hc164的驱动程序
  // ---------------------------------------------------------------------------
  hc164_driver hc164_driver_inst(
      .clk         ( clk ),
      .rst_n       ( rst_n ),
      .dot         ( data_dot ),
      .seg_value   ( data ),
      .hc_cp       ( hc_cp ), 
      .hc_si       ( hc_si )  
      );
       
endmodule