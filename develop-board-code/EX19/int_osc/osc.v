// megafunction wizard: %MAX II oscillator%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altufm_osc 

// ============================================================
// File Name: osc.v
// Megafunction Name(s):
// 			altufm_osc
//
// Simulation Library Files(s):
// 			maxii
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 7.2 Build 151 09/26/2007 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2007 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altufm_osc CBX_AUTO_BLACKBOX="ALL" OSC_FREQUENCY=180000 osc oscena
//VERSION_BEGIN 7.2 cbx_altufm_osc 2006:01:02:18:34:30:SJ cbx_maxii 2007:04:30:09:54:50:SJ cbx_mgl 2007:08:03:15:48:12:SJ cbx_stratixii 2007:06:28:17:26:26:SJ cbx_util_mgl 2007:06:01:06:37:30:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = maxii_ufm 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  osc_altufm_osc_rv5
	( 
	osc,
	oscena) /* synthesis synthesis_clearbox=1 */;
	output   osc;
	input   oscena;

	wire  wire_maxii_ufm_block1_osc;

	maxii_ufm   maxii_ufm_block1
	( 
	.arclk(1'b0),
	.ardin(1'b0),
	.arshft(1'b0),
	.bgpbusy(),
	.busy(),
	.drclk(1'b0),
	.drdout(),
	.drshft(1'b0),
	.osc(wire_maxii_ufm_block1_osc),
	.oscena(oscena)
	`ifdef FORMAL_VERIFICATION
	`else
	// synopsys translate_off
	`endif
	,
	.drdin(1'b0),
	.erase(1'b0),
	.program(1'b0)
	`ifdef FORMAL_VERIFICATION
	`else
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.ctrl_bgpbusy(1'b0),
	.devclrn(1'b1),
	.devpor(1'b1),
	.sbdin(1'b0),
	.sbdout()
	// synopsys translate_on
	);
	defparam
		maxii_ufm_block1.address_width = 9,
		maxii_ufm_block1.osc_sim_setting = 180000,
		maxii_ufm_block1.lpm_type = "maxii_ufm";
	assign
		osc = wire_maxii_ufm_block1_osc;
endmodule //osc_altufm_osc_rv5
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module osc (
	oscena,
	osc)/* synthesis synthesis_clearbox = 1 */;

	input	  oscena;
	output	  osc;

	wire  sub_wire0;
	wire  osc = sub_wire0;

	osc_altufm_osc_rv5	osc_altufm_osc_rv5_component (
				.oscena (oscena),
				.osc (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "MAX II"
// Retrieval info: PRIVATE: INTENDED_DEVICE_PART STRING ""
// Retrieval info: PRIVATE: INTERFACE_CHOICE NUMERIC "4"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: VERSION_NUMBER NUMERIC "0"
// Retrieval info: CONSTANT: OSC_FREQUENCY NUMERIC "180000"
// Retrieval info: USED_PORT: osc 0 0 0 0 OUTPUT NODEFVAL osc
// Retrieval info: USED_PORT: oscena 0 0 0 0 INPUT NODEFVAL oscena
// Retrieval info: CONNECT: @oscena 0 0 0 0 oscena 0 0 0 0
// Retrieval info: CONNECT: osc 0 0 0 0 @osc 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL osc.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL osc.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL osc.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL osc.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL osc_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL osc_bb.v FALSE
// Retrieval info: LIB_FILE: maxii