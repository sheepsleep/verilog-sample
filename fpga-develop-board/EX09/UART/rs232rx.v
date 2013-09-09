//-----------------------------------------
// This block takes care of receiving an RS232 input word,
// from the "rxd" line in a serial fashion.
// The user is responsible for providing appropriate CLK
// and clock enable (CE) to achieve the desired Baudot interval
// (NOTE: the state machine operates at "CLOCK_FACTOR_PP" times the
//   desired BAUD rate.  Set it to anything between 2 and 16,
//   inclusive.  Values higher than 16 will not "buy" much for you,
//   and the state machine might not work well for values less than
//   four either, because of the difficulty in sampling rxd at the
//   "middle" of the bit time.  However, it may be useful to adjust
//   the clock_factor around in order to generate good BAUD clocks
//   from odd Fclk frequencies on your board.)
// Each time the "word_ready" line drives high the unit has put
// a newly received data word into its output buffer, and is possibly
// already in the process of receiving the next one.
// Note that support is not provided for 1.5 stop bits, only integral
// numbers of stop bits are allowed.  However, a selection >2 for
// number of stop bits will still work (it will simply receive
// and count additional stop bits before reporting "word_ready"

`timescale 1ns/100ps
module rs232rx (
                clk,
                rx_clk,
                reset,
                rxd,
                read,//表示已经将接收到的一帧数据取走,可以传送下一字节到接收Buffer
                data,
                data_ready,// 8 bit UART data准备好标志,高电平：表示接收的完整数据已在输出缓冲准备好，可以取走
                error_over_run,
                error_under_run,
                error_all_low
                );

// Parameter declarations
parameter START_BITS_PP  = 1;
parameter DATA_BITS_PP  = 8;
parameter STOP_BITS_PP  = 1;
parameter CLOCK_FACTOR_PP  = 16;

// State encodings, provided as parameters
// for flexibility to the one instantiating the module

parameter m1_idle = 0;
parameter m1_start = 1;
parameter m1_shift = 3;
parameter m1_over_run = 2;
parameter m1_under_run = 4;
parameter m1_all_low = 5;
parameter m1_extra_1 = 6;
parameter m1_extra_2 = 7;
parameter m2_data_ready_ack = 0;
parameter m2_data_ready_flag = 1;



// I/O declarations
input clk; 
input rx_clk; 
input reset;
input rxd;
input read;   

output [DATA_BITS_PP-1:0] data; // 8 bit UART data
output data_ready;   
output error_over_run; //在发生错误后必须reset才能推出错误死循环
output error_under_run;
output error_all_low;

reg [DATA_BITS_PP-1:0] data;
reg data_ready;
reg error_over_run;  //stop bit error,导致over error
reg error_under_run; //start bit error,导致under error 
reg error_all_low;   //全部为低电平（包括stop）,导致all low error

// Local signal declarations
`define TOTAL_BITS START_BITS_PP + DATA_BITS_PP + STOP_BITS_PP

wire word_xfer_l;  //表示一帧数据完整接收到
wire mid_bit_l;    //1 bit UART data信号的中间采样点标志
wire start_bit_l;  // start bit flag
wire stop_bit_l;   // stop bit flag
wire all_low_l;    //接收到的一帧数据全为“０”

reg [3:0] intrabit_count_l; // 确定中间采样点的counter
reg [`TOTAL_BITS-1:0] q; //用于保存接收到的一帧数据
reg shifter_preset; //=1-> intrabit_count_l = 0 | q <= -1
reg [2:0] m1_state;
reg [2:0] m1_next_state;
reg m2_state;
reg m2_next_state;


  // State register
  always @(posedge clk)
  begin : m1_state_register
    if (reset) m1_state <= m1_idle;
    else m1_state <= m1_next_state;
  end 

  always @(m1_state 
           or reset
           or rxd
           or mid_bit_l
           or all_low_l
           or start_bit_l
           or stop_bit_l
           )
  begin : m1_state_logic
  
    // Output signals are low unless set high in a state condition.
    shifter_preset <= 0;   //在出错后，能够及时重新reset,开始新的检测
    error_over_run <= 0;
    error_under_run <= 0;
    error_all_low <= 0;
  
    case (m1_state)

      m1_idle :
        begin
          shifter_preset <= 1'b1;
          if (~rxd) m1_next_state <= m1_start;
          else m1_next_state <= m1_idle;
        end

      m1_start :
        begin
          if (~rxd && mid_bit_l) m1_next_state <= m1_shift;
          else if (rxd && mid_bit_l) m1_next_state <= m1_under_run;
          else m1_next_state <= m1_start;
        end

      m1_shift :
        begin
          if (all_low_l) m1_next_state <= m1_all_low;
          else if (~start_bit_l && ~stop_bit_l) m1_next_state <= m1_over_run;
          else if (~start_bit_l && stop_bit_l) m1_next_state <= m1_idle;
          else m1_next_state <= m1_shift;
        end

      m1_over_run :
        begin
          error_over_run <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_over_run;
        end
      
      m1_under_run :
        begin
          error_under_run <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_under_run;
        end
        
      m1_all_low :
        begin
          error_all_low <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_all_low;
        end
        
      default : m1_next_state <= m1_idle;
    endcase 
  end 
  assign word_xfer_l = ((m1_state == m1_shift) && ~start_bit_l && stop_bit_l);

  // State register
  always @(posedge clk)
  begin : m2_state_register
    if (reset) m2_state <= m2_data_ready_ack;
    else m2_state <= m2_next_state;
  end 

  // State transition logic
  always @(m2_state or word_xfer_l or read)
  begin : m2_state_logic
    case (m2_state)
      m2_data_ready_ack:
            begin
              data_ready <= 1'b0;
              if (word_xfer_l) m2_next_state <= m2_data_ready_flag;
              else m2_next_state <= m2_data_ready_ack;
            end
      m2_data_ready_flag:
            begin
              data_ready <= 1'b1;
              if (read) m2_next_state <= m2_data_ready_ack;
              else m2_next_state <= m2_data_ready_flag;
            end
      default : m2_next_state <= m2_data_ready_ack;
    endcase 
  end 

  // This counts within a bit-time.
  always @(posedge clk)
  begin
    if (shifter_preset) intrabit_count_l <= 0;
    else if (rx_clk)
    begin
      if (intrabit_count_l == (CLOCK_FACTOR_PP-1)) intrabit_count_l <= 0;
      else intrabit_count_l <= intrabit_count_l + 1;
    end
  end
  // This signal gets one "rx_clk" at the middle of the bit time.
  assign mid_bit_l = ((intrabit_count_l==(CLOCK_FACTOR_PP / 2)) && rx_clk);

  // This is the shift register
  always @(posedge clk)
  begin : rxd_shifter
    if (shifter_preset) q <= -1; // Set to all ones.
    else if (mid_bit_l) q <= {rxd,q[`TOTAL_BITS-1:1]};
  end
  // Note: The definitions of "start_bit_l" and "stop_bit_l" could
  //       well be updated to include _all_ of the start and stop bits.
  assign start_bit_l = q[0];
  assign stop_bit_l = q[`TOTAL_BITS-1];
  assign all_low_l = ~(| q); // Bit-wise or of the entire shift register


  // This is the output buffer
  always @(posedge clk)
  begin : rxd_output
    if (reset) data <= 0;
    else if (word_xfer_l) 
      data <= q[START_BITS_PP+DATA_BITS_PP-1:START_BITS_PP];
  end

endmodule

//`undef TOTAL_BITS