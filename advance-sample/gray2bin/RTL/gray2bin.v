/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			bin2gray
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		bin 2 gray
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
module gray2bin ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              addr_gray,

              //output 
              addr
              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input  [WIDTH-1:0]       addr_gray;

//output ports
output [WIDTH-1:0]       addr;

//reg define 
reg    [WIDTH-1:0]       addr;


//wire define 
wire   [WIDTH-1:0]       addr_gray;

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

function  [SIZE-1:0] GRAY2BIN;
	input [SIZE-1:0] gray_code;
	integer i;
	begin 
	for (i = 0; i<SIZE;i=i+1)
		GRAY2BIN[i]= ^(gray_code>>i);
	end
endfunction

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            addr <= 8'b0;
        end
        else  
            addr  <= GRAY2BIN(addr_gray);
end




endmodule
//end of RTL code                       