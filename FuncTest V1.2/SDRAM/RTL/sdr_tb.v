/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           SDRAM_TB
** Last modified Date:  2011-9-18
** Last Version:        1.0
** Descriptions:        SDRAM_TB
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-10-18
** Version:             1.0
** Descriptions:        The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module sdr_tb (

// common interface				   
input                          sys_clk     ,                        // SYS CLK, 50Mhz
input                          sys_rst_n   ,                          

output reg     [ 7:0]          LED         ,


inout          [ 7:0]          sdr_DQ      ,

output wire    [11:0]          sdr_A       ,
output wire    [ 1:0]          sdr_BA      ,
output wire                    sdr_CKE     ,

output wire                    sdr_CLK     ,

output wire                    sdr_CSn     ,
output wire                    sdr_RASn    ,
output wire                    sdr_CASn    ,
output wire                    sdr_WEn     ,
output wire                    sdr_DQM      );

`include "sdr_par.v"

wire sys_R_Wn;      // read/write#
wire sys_ADSn;      // address strobe
wire sys_DLY_100US; // sdr power and clock stable for 100 us
wire sys_CLK;       // sdr clock
wire sys_RESET;     // reset signal
wire sys_REF_REQ;   // sdr auto-refresh request
wire sys_REF_ACK;   // sdr auto-refresh acknowledge
wire [23:1] sys_A;  // address bus
wire [15:0] sys_D;  // data bus
wire sys_D_VALID;   // data valid
wire sys_CYC_END;   // end of current cycle
wire sys_INIT_DONE; // initialization completed, ready for normal operation

wire [3:0] sdr_DQ_tmp ; 

//---------------------------------------------------------------------
// modules

assign sdr_CLK = sys_CLK ; 

always @(posedge sys_CLK or posedge sys_RESET) begin
      if (sys_RESET)
          LED <= 8'h0;
      else if ( sys_D_VALID == 1'b1 )
          LED <= sdr_DQ;
      else ;
end

assign sdr_DQ = {  sdr_DQ_tmp , sdr_DQ_tmp } ;

sdr_top UUT(
  .sys_R_Wn(sys_R_Wn),                    // read/write#
  .sys_ADSn(sys_ADSn),                    // address strobe
  .sys_DLY_100US(sys_DLY_100US),          // sdr power and clock stable for 100 us
  .sys_CLK(sys_CLK),                      // sdr clock
  .sys_RESET(sys_RESET),                  // reset signal
  .sys_REF_REQ(sys_REF_REQ),              // sdr auto-refresh request
  .sys_REF_ACK(sys_REF_ACK),              // sdr auto-refresh acknowledge
  .sys_A(sys_A),                          // address bus
  .sys_D(sys_D),                          // data bus
  .sys_D_VALID(sys_D_VALID),              // data valid
  .sys_CYC_END(sys_CYC_END),              // end of current cycle
  .sys_INIT_DONE(sys_INIT_DONE),          // initialization completed, ready for normal operation

  .sdr_DQ(sdr_DQ_tmp),                    // sdr data
  .sdr_A(sdr_A),                          // sdr address
  .sdr_BA(sdr_BA),                        // sdr bank address
  .sdr_CKE(sdr_CKE),                      // sdr clock enable
  .sdr_CSn(sdr_CSn),                      // sdr chip select
  .sdr_RASn(sdr_RASn),                    // sdr row address
  .sdr_CASn(sdr_CASn),                    // sdr column select
  .sdr_WEn(sdr_WEn),                      // sdr write enable
  .sdr_DQM(sdr_DQM)                       // sdr write data mask
);                            

BFM BFM_U0 (
  .sys_clk        (sys_clk         ),
  .sys_rst_n      (sys_rst_n       ),
  .sys_CLK        (sys_CLK         ),
  .sys_RESET      (sys_RESET       ),
  .sys_A          (sys_A           ),
  .sys_ADSn       (sys_ADSn        ),
  .sys_R_Wn       (sys_R_Wn        ),
  .sys_D          (sys_D           ),
  .sys_DLY_100US  (sys_DLY_100US   ),
  .sys_REF_REQ    (sys_REF_REQ     ),
  .sys_CYC_END    (sys_CYC_END     ),
  .sys_INIT_DONE  (sys_INIT_DONE   )
);
             
endmodule    

