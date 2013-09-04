/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			LFSR
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		LFSR
**------------------------------------------------------------------------------------------------------
** Created by:		    dongdong
** Created date:		2009-10-18
** Version:				1.0
** Descriptions:		The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module LFSR ( 
              //input 
			  sys_clk,

              //output 
              out
              );

//input ports

input                    sys_clk;      //system clock;

//output ports
output [WIDTH-1:0]       out;

//reg define 
reg                      out_ff1;
reg                      out_ff2;
reg                      out_ff3;

//wire define 
wire [WIDTH-1:0]         out;

//parameter define 
parameter WIDTH = 1;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk ) begin 
    out_ff2  <= out_ff1;
end

always @(posedge sys_clk ) begin 
    out_ff3  <= out_ff2;
end

always @(posedge sys_clk ) begin 
    out_ff1  <= out_ff3 ^out_ff2;
end

assign out = out_ff3;

endmodule
//end of RTL code                       