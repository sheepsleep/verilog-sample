/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			key_debounce
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		key to debounce
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
module key_debounce( 
					//input 
					sys_clk,
					sys_rst_n,
					key_in,
				    //output 
					key_out
                    );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input  [KEY_WIDTH-1:0]             key_in;

//output ports
output [KEY_WIDTH-1:0]             key_out;

//reg define 
reg    [KEY_WIDTH-1:0]             key_dly1;
reg    [KEY_WIDTH-1:0]             key_dly2;
reg    [KEY_WIDTH-1:0]             key_dly3;
//wire define 
wire   [KEY_WIDTH-1:0]             key_in;
wire   [KEY_WIDTH-1:0]             key_out;

//parameter define 
parameter KEY_WIDTH = 4;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
//delay for sync
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            key_dly1 <= 1'b0;
            key_dly2 <= 1'b0;
            key_dly3 <= 1'b0;
        end
        else begin 
            key_dly1 <= key_in;
            key_dly2 <= key_dly1;
            key_dly3 <= key_dly2;
        end
end
//or the reg 

assign key_out = key_dly1 | key_dly2 | key_dly3;

endmodule
//end of RTL code                       