// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2001 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
// Permission:
//
//   Lattice Semiconductor grants permission to use this code for use
//   in synthesis for any Lattice programmable logic product.  Other
//   use of this code, including the selling or duplication of any
//   portion is strictly prohibited.
//
// Disclaimer:
//
//
// This is the test bench module of the SDR SDRAM controller reference
// design.  It is highly recommanded to download simulation modules
// from the SDRAM venders when you are working on the modification of
// the SDR SDRAM controller reference design.
//
// --------------------------------------------------------------------

`timescale 1ns / 100ps


module sdr_tb (

// common interface				   
input                               sys_clk     ,                        // SYS CLK, 50Mhz
input                               sys_rst_n                             


//inout [3:0]                sdr_DQ,


//output [12-1:0]   sdr_A,
//output [2-1:0]  sdr_BA,
//output                     sdr_CKE,
//output                     sdr_CSn,
//output                     sdr_RASn,
//output                     sdr_CASn,
//output                     sdr_WEn,
//output                     sdr_DQM
);

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


wire [3:0] sdr_DQ;  // sdr data
wire [11:0] sdr_A;  // sdr address
wire [1:0] sdr_BA;  // sdr bank address
wire sdr_CKE;       // sdr clock enable
wire sdr_CSn;       // sdr chip select
wire sdr_RASn;      // sdr row address
wire sdr_CASn;      // sdr column select
wire sdr_WEn;       // sdr write enable
wire sdr_DQM;       // sdr write data mask

//---------------------------------------------------------------------
// modules

sdr_top UUT(
  .sys_R_Wn(sys_R_Wn),      // read/write#
  .sys_ADSn(sys_ADSn),      // address strobe
  .sys_DLY_100US(sys_DLY_100US), // sdr power and clock stable for 100 us
  .sys_CLK(sys_CLK),       // sdr clock
  .sys_RESET(sys_RESET),     // reset signal
  .sys_REF_REQ(sys_REF_REQ),   // sdr auto-refresh request
  .sys_REF_ACK(sys_REF_ACK),   // sdr auto-refresh acknowledge
  .sys_A(sys_A),         // address bus
  .sys_D(sys_D),         // data bus
  .sys_D_VALID(sys_D_VALID),   // data valid
  .sys_CYC_END(sys_CYC_END),   // end of current cycle
  .sys_INIT_DONE(sys_INIT_DONE), // initialization completed, ready for normal operation

  .sdr_DQ(sdr_DQ),        // sdr data
  .sdr_A(sdr_A),         // sdr address
  .sdr_BA(sdr_BA),        // sdr bank address
  .sdr_CKE(sdr_CKE),       // sdr clock enable
  .sdr_CSn(sdr_CSn),       // sdr chip select
  .sdr_RASn(sdr_RASn),      // sdr row address
  .sdr_CASn(sdr_CASn),      // sdr column select
  .sdr_WEn(sdr_WEn),       // sdr write enable
  .sdr_DQM(sdr_DQM)        // sdr write data mask
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
             
sdr SDR_SDRAM(
  sdr_DQ,
  sdr_A,
  sdr_BA,
  sys_CLK,
  sdr_CKE,
  sdr_CSn,
  sdr_RASn,
  sdr_CASn,
  sdr_WEn,
  sdr_DQM
);

endmodule    

