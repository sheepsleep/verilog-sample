// megafunction wizard: %Shift register (RAM-based)%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altshift_taps 

// ============================================================
// File Name: shift_ram.v
// Megafunction Name(s):
// 			altshift_taps
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 8.1 Build 163 10/28/2008 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2008 Altera Corporation
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


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module shift_ram (
	clken,
	clock,
	shiftin,
	shiftout,
	taps0x,
	taps1x,
	taps2x,
	taps3x,
	taps4x,
	taps5x,
	taps6x,
	taps7x);

	input	  clken;
	input	  clock;
	input	[3:0]  shiftin;
	output	[3:0]  shiftout;
	output	[3:0]  taps0x;
	output	[3:0]  taps1x;
	output	[3:0]  taps2x;
	output	[3:0]  taps3x;
	output	[3:0]  taps4x;
	output	[3:0]  taps5x;
	output	[3:0]  taps6x;
	output	[3:0]  taps7x;

	wire [31:0] sub_wire0;
	wire [3:0] sub_wire10;
	wire [23:20] sub_wire14 = sub_wire0[23:20];
	wire [27:24] sub_wire13 = sub_wire0[27:24];
	wire [27:24] sub_wire12 = sub_wire13[27:24];
	wire [31:28] sub_wire11 = sub_wire0[31:28];
	wire [31:28] sub_wire9 = sub_wire11[31:28];
	wire [7:4] sub_wire7 = sub_wire0[7:4];
	wire [3:0] sub_wire8 = sub_wire0[3:0];
	wire [11:8] sub_wire6 = sub_wire0[11:8];
	wire [11:8] sub_wire5 = sub_wire6[11:8];
	wire [15:12] sub_wire4 = sub_wire0[15:12];
	wire [15:12] sub_wire3 = sub_wire4[15:12];
	wire [19:16] sub_wire2 = sub_wire0[19:16];
	wire [19:16] sub_wire1 = sub_wire2[19:16];
	wire [3:0] taps4x = sub_wire1[19:16];
	wire [3:0] taps3x = sub_wire3[15:12];
	wire [3:0] taps2x = sub_wire5[11:8];
	wire [3:0] taps1x = sub_wire7[7:4];
	wire [3:0] taps0x = sub_wire8[3:0];
	wire [3:0] taps7x = sub_wire9[31:28];
	wire [3:0] shiftout = sub_wire10[3:0];
	wire [3:0] taps6x = sub_wire12[27:24];
	wire [3:0] taps5x = sub_wire14[23:20];

	altshift_taps	altshift_taps_component (
				.clken (clken),
				.clock (clock),
				.shiftin (shiftin),
				.taps (sub_wire0),
				.shiftout (sub_wire10)
				// synopsys translate_off
				,
				.aclr ()
				// synopsys translate_on
				);
	defparam
		altshift_taps_component.lpm_hint = "RAM_BLOCK_TYPE=M4K",
		altshift_taps_component.lpm_type = "altshift_taps",
		altshift_taps_component.number_of_taps = 8,
		altshift_taps_component.tap_distance = 4,
		altshift_taps_component.width = 4;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "0"
// Retrieval info: PRIVATE: CLKEN NUMERIC "1"
// Retrieval info: PRIVATE: GROUP_TAPS NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone"
// Retrieval info: PRIVATE: NUMBER_OF_TAPS NUMERIC "8"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: TAP_DISTANCE NUMERIC "4"
// Retrieval info: PRIVATE: WIDTH NUMERIC "4"
// Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=M4K"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altshift_taps"
// Retrieval info: CONSTANT: NUMBER_OF_TAPS NUMERIC "8"
// Retrieval info: CONSTANT: TAP_DISTANCE NUMERIC "4"
// Retrieval info: CONSTANT: WIDTH NUMERIC "4"
// Retrieval info: USED_PORT: clken 0 0 0 0 INPUT VCC clken
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: shiftin 0 0 4 0 INPUT NODEFVAL shiftin[3..0]
// Retrieval info: USED_PORT: shiftout 0 0 4 0 OUTPUT NODEFVAL shiftout[3..0]
// Retrieval info: USED_PORT: taps0x 0 0 4 0 OUTPUT NODEFVAL taps0x[3..0]
// Retrieval info: USED_PORT: taps1x 0 0 4 0 OUTPUT NODEFVAL taps1x[3..0]
// Retrieval info: USED_PORT: taps2x 0 0 4 0 OUTPUT NODEFVAL taps2x[3..0]
// Retrieval info: USED_PORT: taps3x 0 0 4 0 OUTPUT NODEFVAL taps3x[3..0]
// Retrieval info: USED_PORT: taps4x 0 0 4 0 OUTPUT NODEFVAL taps4x[3..0]
// Retrieval info: USED_PORT: taps5x 0 0 4 0 OUTPUT NODEFVAL taps5x[3..0]
// Retrieval info: USED_PORT: taps6x 0 0 4 0 OUTPUT NODEFVAL taps6x[3..0]
// Retrieval info: USED_PORT: taps7x 0 0 4 0 OUTPUT NODEFVAL taps7x[3..0]
// Retrieval info: CONNECT: @shiftin 0 0 4 0 shiftin 0 0 4 0
// Retrieval info: CONNECT: shiftout 0 0 4 0 @shiftout 0 0 4 0
// Retrieval info: CONNECT: taps0x 0 0 4 0 @taps 0 0 4 0
// Retrieval info: CONNECT: taps1x 0 0 4 0 @taps 0 0 4 4
// Retrieval info: CONNECT: taps2x 0 0 4 0 @taps 0 0 4 8
// Retrieval info: CONNECT: taps3x 0 0 4 0 @taps 0 0 4 12
// Retrieval info: CONNECT: taps4x 0 0 4 0 @taps 0 0 4 16
// Retrieval info: CONNECT: taps5x 0 0 4 0 @taps 0 0 4 20
// Retrieval info: CONNECT: taps6x 0 0 4 0 @taps 0 0 4 24
// Retrieval info: CONNECT: taps7x 0 0 4 0 @taps 0 0 4 28
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @clken 0 0 0 0 clken 0 0 0 0
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram_waveforms.html TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift_ram_wave*.jpg FALSE
// Retrieval info: LIB_FILE: altera_mf
