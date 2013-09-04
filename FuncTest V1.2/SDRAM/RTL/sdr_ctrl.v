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
//   This VHDL or Verilog source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Lattice Semiconductor provides no warranty
//   regarding the use or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A
//
//                     TEL: 1-800-Lattice (USA and Canada)
//                          408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// This is the main control module of the SDR SDRAM controller
// reference design.
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V0.9 :| J.H.              :| 07/11/01  :| Pre-Release
// --------------------------------------------------------------------

`timescale 1ns / 100ps

module sdr_ctrl(
  sys_CLK,
  sys_RESET,
  sys_R_Wn,
  sys_ADSn,
  sys_DLY_100US,
  sys_REF_REQ,
  sys_REF_ACK,
  sys_CYC_END,
  sys_INIT_DONE,
  iState,
  cState,
  clkCNT
);

`include "sdr_par.v"

//---------------------------------------------------------------------
// inputs
//
input        sys_CLK;
input        sys_RESET;
input        sys_R_Wn;
input        sys_ADSn;
input        sys_DLY_100US;
input        sys_REF_REQ;
                                   
//---------------------------------------------------------------------
// outputs
//
output       sys_REF_ACK;
output       sys_CYC_END;
output       sys_INIT_DONE;
output [3:0] iState;
output [3:0] cState;
output [3:0] clkCNT;

//---------------------------------------------------------------------
// registers
//
reg          sys_INIT_DONE;  // indicates sdr initialization is done

reg [3:0]    iState;        // INIT_FSM state variables
reg [3:0]    cState;        // CMD_FSM state variables
reg          sys_REF_ACK;
reg          sys_CYC_END;

reg [3:0]    clkCNT;
reg          syncResetClkCNT; // reset clkCNT to 0

//---------------------------------------------------------------------
// local definitions
//
`define endOf_tRP          clkCNT == NUM_CLK_tRP
`define endOf_tRFC         clkCNT == NUM_CLK_tRFC
`define endOf_tMRD         clkCNT == NUM_CLK_tMRD
`define endOf_tRCD         clkCNT == NUM_CLK_tRCD
`define endOf_Cas_Latency  clkCNT == NUM_CLK_CL
`define endOf_Read_Burst   clkCNT == NUM_CLK_READ - 1
`define endOf_Write_Burst  clkCNT == NUM_CLK_WRITE
`define endOf_tDAL         clkCNT == NUM_CLK_WAIT

//---------------------------------------------------------------------
// INIT_FSM state machine
//
always @(posedge sys_CLK or posedge sys_RESET)
  if (sys_RESET) begin
     iState <= #tDLY i_NOP;
  end else
    case (iState)
      i_NOP:   // wait for 100 us delay by checking sys_DLY_100US
               if (sys_DLY_100US) iState <= #tDLY i_PRE;
      i_PRE:   // precharge all
               iState <= #tDLY (NUM_CLK_tRP == 0) ? i_AR1 : i_tRP;
      i_tRP:   // wait until tRP satisfied
               if (`endOf_tRP) iState <= #tDLY i_AR1;
      i_AR1:   // auto referesh
               iState <= #tDLY (NUM_CLK_tRFC == 0) ? i_AR2 : i_tRFC1;
      i_tRFC1: // wait until tRFC satisfied
               if (`endOf_tRFC) iState <= #tDLY i_AR2;
      i_AR2:   // auto referesh
               iState <= #tDLY (NUM_CLK_tRFC == 0) ? i_MRS : i_tRFC2;
      i_tRFC2: // wait until tRFC satisfied
               if (`endOf_tRFC) iState <= #tDLY i_MRS;
      i_MRS:   // load mode register
               iState <= #tDLY (NUM_CLK_tMRD == 0) ? i_ready : i_tMRD;
      i_tMRD:  // wait until tMRD satisfied
               if (`endOf_tMRD) iState <= #tDLY i_ready;
      i_ready: // stay at this state for normal operation
               iState <= #tDLY i_ready;
      default:
               iState <= #tDLY i_NOP;
    endcase

//
// sys_INIT_DONE generation
//
always @(posedge sys_CLK or posedge sys_RESET)
  if (sys_RESET) begin
     sys_INIT_DONE <= #tDLY 0;
  end else
    case (iState)
      i_ready: sys_INIT_DONE <= #tDLY 1;
      default: sys_INIT_DONE <= #tDLY 0;
    endcase

//---------------------------------------------------------------------
// CMD_FSM state machine
//
always @(posedge sys_CLK or posedge sys_RESET)
  if (sys_RESET) begin
     cState <= #tDLY c_idle;
  end else
    case (cState)
      c_idle:   // wait until refresh request or addr strobe asserted
                if (sys_REF_REQ && sys_INIT_DONE) cState <= #tDLY c_AR;
                else if (!sys_ADSn && sys_INIT_DONE) cState <= #tDLY c_ACTIVE;
      c_ACTIVE: // assert row/bank addr
                if (NUM_CLK_tRCD == 0)
                   cState <= #tDLY (sys_R_Wn) ? c_READA : c_WRITEA;
                else cState <= #tDLY c_tRCD;
      c_tRCD:   // wait until tRCD satisfied
                if (`endOf_tRCD)
                   cState <= #tDLY (sys_R_Wn) ? c_READA : c_WRITEA;
      c_READA:  // assert col/bank addr for read with auto-precharge
                cState <= #tDLY c_cl;
      c_cl:     // CASn latency
                if (`endOf_Cas_Latency) cState <= #tDLY c_rdata;
      c_rdata:  // read cycle data phase
                if (`endOf_Read_Burst) cState <= #tDLY c_idle;
      c_WRITEA: // assert col/bank addr for write with auto-precharge
                cState <= #tDLY c_wdata;
      c_wdata:  // write cycle data phase
                if (`endOf_Write_Burst) cState <= #tDLY c_tDAL;
      c_tDAL:   // wait until (tWR + tRP) satisfied before issuing next
                // SDRAM ACTIVE command
                if (`endOf_tDAL) cState <= #tDLY c_idle;
      c_AR:     // auto-refresh
                cState <= #tDLY (NUM_CLK_tRFC == 0) ? c_idle : c_tRFC;
      c_tRFC:   // wait until tRFC satisfied
                if (`endOf_tRFC) cState <= #tDLY c_idle;
      default:
                cState <= #tDLY c_idle;
    endcase

//
// sys_REF_ACK generation
//
always @(posedge sys_CLK or posedge sys_RESET)
  if (sys_RESET) begin
     sys_REF_ACK <= #tDLY 0;
  end else
    case (cState)
      c_idle:
         if (sys_REF_REQ && sys_INIT_DONE) sys_REF_ACK <= #tDLY 1;
         else sys_REF_ACK <= #tDLY 0;
      c_AR:
         if (NUM_CLK_tRFC == 0) sys_REF_ACK <= #tDLY 0;
         else sys_REF_ACK <= #tDLY 1;
      default:
         sys_REF_ACK <= #tDLY 0;
    endcase

//
// sys_CYC_END generation
//
always @(posedge sys_CLK or posedge sys_RESET)
  if (sys_RESET) begin
     sys_CYC_END <= #tDLY 1;
  end else
    case (cState)
      c_idle:
         if (sys_REF_REQ && sys_INIT_DONE) sys_CYC_END <= #tDLY 1;
         else if (!sys_ADSn && sys_INIT_DONE) sys_CYC_END <= #tDLY 0;
         else sys_CYC_END <= #tDLY 1;
      c_ACTIVE,
      c_tRCD,
      c_READA,
      c_cl,
      c_WRITEA,
      c_wdata:
         sys_CYC_END <= #tDLY 0;
      c_rdata:
         sys_CYC_END <= #tDLY (`endOf_Read_Burst) ? 1 : 0;
      c_tDAL:
         sys_CYC_END <= #tDLY (`endOf_tDAL) ? 1 : 0;
      default:
         sys_CYC_END <= #tDLY 1;
    endcase

//---------------------------------------------------------------------
// Clock Counter
//
always @(posedge sys_CLK)
  if (syncResetClkCNT) clkCNT <= #tDLY 0;
  else clkCNT <= #tDLY clkCNT + 1;

//
// syncResetClkCNT generation
//
always @(iState or cState or clkCNT)
  case (iState)
    i_PRE:
         syncResetClkCNT <= #tDLY (NUM_CLK_tRP == 0) ? 1 : 0;
    i_AR1,
    i_AR2:
         syncResetClkCNT <= #tDLY (NUM_CLK_tRFC == 0) ? 1 : 0;
    i_NOP:
         syncResetClkCNT <= #tDLY 1;
    i_tRP:
         syncResetClkCNT <= #tDLY (`endOf_tRP) ? 1 : 0;
    i_tMRD:
         syncResetClkCNT <= #tDLY (`endOf_tMRD) ? 1 : 0;
    i_tRFC1,
    i_tRFC2:
         syncResetClkCNT <= #tDLY (`endOf_tRFC) ? 1 : 0;
    i_ready:
         case (cState)
           c_ACTIVE:
                syncResetClkCNT <= #tDLY (NUM_CLK_tRCD == 0) ? 1 : 0;
           c_idle:
                syncResetClkCNT <= #tDLY 1;
           c_tRCD:
                syncResetClkCNT <= #tDLY (`endOf_tRCD) ? 1 : 0;
           c_tRFC:
                syncResetClkCNT <= #tDLY (`endOf_tRFC) ? 1 : 0;
           c_cl:
                syncResetClkCNT <= #tDLY (`endOf_Cas_Latency) ? 1 : 0;
           c_rdata:
                syncResetClkCNT <= #tDLY (clkCNT == NUM_CLK_READ) ? 1 : 0;
           c_wdata:
                syncResetClkCNT <= #tDLY (`endOf_Write_Burst) ? 1 : 0;
           default:
                syncResetClkCNT <= #tDLY 0;
         endcase
    default:
         syncResetClkCNT <= #tDLY 0;
  endcase

endmodule
		

                  



