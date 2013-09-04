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

module UART(
	                  clk,
	                  rst_n,
                    Uart2_R,
                    Uart2_T
                    );
input	    clk;
input	    rst_n;
input     Uart2_R;  
output    Uart2_T;


wire [2:0] rs232_rx_error;
wire rx232_tx_load_request;
wire rs232_rx_data_ready;
wire [7:0] rs232_rx_character;
 
 
// These defines are for the rs232 interface
`define START_BITS 1
`define DATA_BITS 8
`define STOP_BITS 1
`define CLOCK_FACTOR 16

wire serial_clk_16x;

// This unit generates the correct 16x transmit clock (enable) frequency
// which is used for the serial transmit operation.
clock_gen_select clock_unit
  (
   .clk(clk),
   .reset(!rst_n),
   .rate_select(3'b000),         
   .clk_out(serial_clk_16x)
  );

// A transmitter, which asserts load_request at the end of the currently
// transmitted word.  The tx_clk must be a "clock enable" (narrow positive
// pulse) which occurs at 16x the desired transmit rate.  If load_request
// is connected directly to load, the unit will transmit continuously.
rs232tx #(
          `START_BITS,   // start_bits
          `DATA_BITS,    // data_bits
          `STOP_BITS,    // stop_bits (add intercharacter delay...)
          `CLOCK_FACTOR  // clock_factor
         )
         rs232_tx_block // instance name
         ( 
          .clk(clk),
          .tx_clk(serial_clk_16x),
          .reset(!rst_n),
          .load(  rs232_rx_data_ready && rs232_tx_load_request),
          .data(rs232_rx_character),                 // Connected from keyboard
          .load_request(rx232_tx_load_request),
          .txd(Uart2_T)
         );

// A receiver, which asserts "word_ready" to indicate a received word.
// Asserting "read_word" will cause "word_ready" to go low again if it was high.
// The character is held in the output register, during the time the next
//   character is coming in.
rs232rx #(
          `START_BITS,  // start_bits
          `DATA_BITS,   // data_bits
          `STOP_BITS,   // stop_bits
          `CLOCK_FACTOR // clock_factor
         )
         rs232_rx_block // instance name
         ( 
          .clk(clk),
          .rx_clk(serial_clk_16x),
          .reset((!rst_n) || (| rs232_rx_error) ),
          .rxd(Uart2_R),
          .read(rs232_tx_load_request),
          .data(rs232_rx_character),
          .data_ready(rs232_rx_data_ready),
          .error_over_run(rs232_rx_error[0]),
          .error_under_run(rs232_rx_error[1]),
          .error_all_low(rs232_rx_error[2])
         );

//`undef START_BITS 
//`undef DATA_BITS 
//`undef STOP_BITS 
//`undef CLOCK_FACTOR
      
endmodule
