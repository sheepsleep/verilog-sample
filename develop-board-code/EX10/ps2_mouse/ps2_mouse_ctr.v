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
module	ps2_mouse_ctr(
					input	wire		reset,
					input	wire		clk,
					inout				ps2_data_mouse,
					inout				ps2_clk_mouse,
					output	reg[7:0]	xcont			=	8'd0,
					output	reg[7:0]	ycont			=	8'd0,
					output	reg			lfbut			=	1'b0,
					output	reg			rgbut			=	1'b0,
					output	wire		all_data_rdy
					);

	reg			ps2_data_en		=	1'b1;
	reg			ps2_clk_en		=	1'b1;
	reg[2:0]		ps2_clk_buf		=	3'b000;
	reg[10:0]		data_buf_in		=	11'd0;
	reg[7:0]		memory_1		=	8'd0;
	reg[7:0]		memory_sign		=	8'd0;
	reg[7:0]		memory_xcont	=	8'd0;
	reg[7:0]		memory_ycont	=	8'd0;
	reg			state_b			=	1'b0;
	reg			state_b_1		=	1'b0;
	reg[31:0]		cont_rst		=	31'd0;
	reg			sdata			=	1'b0;
	reg[3:0]		cont_rec		=	4'b0000;
	reg[3:0]		cont_sdata		=	4'd0;
	reg[1:0]		mmr_state		=	2'b00;
	reg[1:0]		mmr_state_next	=	2'b01;
	reg[1:0]		get_data_en		=	2'b00;
	reg[3:0]		no_use			=	4'd0;
	wire			get_data;
	assign		all_data_rdy	=	((get_data_en == 2'b10)&&(mmr_state == 2'b11));
	assign		get_data	=	(cont_rec==4'b1010);
	assign		ps2_clk_mouse	=	ps2_clk_en?1'bz:1'b0;
	assign		ps2_data_mouse	=	ps2_data_en?1'bz:sdata;

//*************************************************************************************//
//---------------------------------reset the systerm--------------------------------------------------//
//************************************************************************************//

//---------------------------------ps2_clk_mouse buffer-----------------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		ps2_clk_buf[2:0]	=	3'b000;
		else
		begin
			ps2_clk_buf[2]	=	ps2_clk_buf[1];
			ps2_clk_buf[1]	=	ps2_clk_buf[0];
			ps2_clk_buf[0]	=	ps2_clk_mouse;
		end
	end
//---------------------------all kind of signs-------------------------------------------------//
	always@(posedge clk	or negedge reset)
	begin
		if(reset==0)
		begin
			state_b		<=	1'b0;
			state_b_1	<=	1'b0;
			ps2_clk_en	<=	1'b0;
		end
		else if(cont_rst	==	32'd12000000)
			ps2_data_en	<=	1'b0;
		else if(cont_rst	==	32'd14000000)
		begin
			ps2_clk_en	<=	1'b1;
			state_b		<=	1'b1;
		end
		else if((ps2_clk_buf[2:0]	==	3'b111)	&&	(cont_sdata	==	4'd11))
		begin
			ps2_data_en	<=	1'd1;
			state_b_1	<=	1'b1;
		end
	end
//---------------------counter for pulling down the ps2_clk for 150us--------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		begin
			cont_rst	<=	32'd0;
		end
		else if(state_b	==	1'b0)
		begin
			if(cont_rst	==	32'd14000000)
			cont_rst	<=	32'd0;
			else
			cont_rst	<=	cont_rst+1;
		end
	end
//--------------------------send the '0xf4' commond to ps2 mouse---------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		begin
			sdata	<=	1'b0;
		end
		else if((state_b	==	1)	&&	(state_b_1	==	0))
		begin
			if(ps2_clk_buf	==	3'b110)
			begin
				case(cont_sdata)
					4'd1	:sdata	<=	1'b0	;
					4'd2	:sdata	<=	1'b0	;
					4'd3	:sdata	<=	1'b1	;
					4'd4	:sdata	<=	1'b0	;
					4'd5	:sdata	<=	1'b1	;
					4'd6	:sdata	<=	1'b1	;
					4'd7	:sdata	<=	1'b1	;
					4'd8	:sdata	<=	1'b1	;
					4'd9	:sdata	<=	1'b0	;
					4'd10	:sdata	<=	1'b1	;
				endcase
			end
		end
	end
//----------------------------counter for signing how many bits of data have been sent---------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		cont_sdata	<=	4'd0;
		else if((ps2_clk_buf[2:0]	==	3'b001)	&&	(state_b_1	==	1'b0)	&&	(state_b==1'b1))
		begin
			if(cont_sdata	==	4'd11)
				cont_sdata	<=	4'd0;
			else
				cont_sdata	<=	cont_sdata+1;
		end
	end

//*************************************************************************************//
//--------------------------receive the data from the ps2 mouse-------------------------------------//
//*************************************************************************************//

//-------------get the data from ''ps2_data_mouse and put it in the data_buf_in---------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		begin
			data_buf_in	=	11'd0;
		end
		else if((state_b_1	==	1'b1)&&(ps2_clk_buf[2:0]	==	3'b110))
		begin
			data_buf_in[0] =	data_buf_in[1];
			data_buf_in[1]	=	data_buf_in[2];
			data_buf_in[2]	=	data_buf_in[3];
			data_buf_in[3]	=	data_buf_in[4];
			data_buf_in[4]	=	data_buf_in[5];
			data_buf_in[5]	=	data_buf_in[6];
			data_buf_in[6]	=	data_buf_in[7];
			data_buf_in[7]	=	data_buf_in[8];
			data_buf_in[8]	=	data_buf_in[9];
			data_buf_in[9]	=	data_buf_in[10];
			data_buf_in[10]	=	ps2_data_mouse;
		end
	end
//------------------------------put the data in the right memory---------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		begin
			memory_1[7:0]		<=	8'd0;
			memory_sign[7:0]	<=	8'd0;
			memory_xcont[7:0]	<=	8'd0;
			memory_ycont[7:0]	<=	8'd0;
		end
		else if(get_data_en[1:0]	==	2'b10)
		begin
			case(mmr_state[1:0])
			2'b00:	{memory_1[7:0],no_use[0]}		<=	{data_buf_in[8:0]};
			2'b01:	{memory_sign[7:0],no_use[1]}	<=	{data_buf_in[8:0]};
			2'b10:	{memory_xcont[7:0],no_use[2]}	<=	{data_buf_in[8:0]};
			2'b11:	{memory_ycont[7:0],no_use[3]}	<=	{data_buf_in[8:0]};
			endcase
		end
	end
//-----------------------make the enable signal of getting data from buffer--------------------------//
//--------------------part1----------------------------------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
			cont_rec[3:0]	<=	4'b1111;
		else if((state_b_1	==	1'b1)&&(ps2_clk_buf[2:0]	==	3'b001))
		begin
			if(cont_rec	==	4'b1010)
				cont_rec[3:0]	<=	4'b0000;
			else
				cont_rec[3:0]	<=	cont_rec[3:0]+1;
		end
	end
//--------------------part2------------------------------------------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
			get_data_en	=	2'b00;
		else
		begin
			get_data_en[1]	=	get_data_en[0];
			get_data_en[0]	=	get_data;
		end
	end
//----------------------------the sign of which memory should the data be put in-------------------------//
//-------------------part1------------------------------------------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
			mmr_state[1:0]	<=	2'b00;
		else if(get_data_en	==	2'b10)
			mmr_state	<=	mmr_state_next;
	end
//---------------------------part2-----------------------------------------------------------------//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
			mmr_state_next	<=	2'b01;
		else                          
		begin                                         
			case(mmr_state)           
			2'b00:	mmr_state_next	<=	2'b01;
			2'b01:	mmr_state_next	<=	2'b10;
			2'b10:	mmr_state_next	<=	2'b11;
			2'b11:	mmr_state_next	<=	2'b01;
			endcase
		end                           
	end 
//*********************************************************************************************************//
//--------------------------------give the output signal----------------------------------------------//
//**********************************************************************************************************//
	always@(posedge	clk	or	negedge	reset)
	begin
		if(reset	==	0)
		begin
			xcont	<=	8'd0;
			ycont	<=	8'd0;
			lfbut	<=	1'b0;
			rgbut	<=	1'b0;
		end
		else if((get_data_en == 2'b10)&&(mmr_state == 2'b11))
		begin
			xcont	<=	memory_xcont;
			ycont	<=	{data_buf_in[8:1]};
			lfbut	<=	memory_sign[0];
			rgbut	<=	memory_sign[1];
		end
		else
		begin
			xcont	<=	xcont;
			ycont	<=	ycont;
			lfbut	<=	lfbut;
			rgbut	<=	rgbut;
		end
	end
endmodule                             
                                      