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
module bin2gray ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              addr,

              //output 
              addr_gray
              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input  [WIDTH-1:0]       addr;

//output ports
output [WIDTH-1:0]       addr_gray;

//reg define 
reg    [WIDTH-1:0]       addr_gray;


//wire define 
wire   [WIDTH-1:0]       addr;

//parameter define 
parameter WIDTH = 8;


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            addr_gray <= 8'b0;
        end
        else  
            addr_gray <= addr^ (addr>>1);
end




endmodule
//end of RTL code                       