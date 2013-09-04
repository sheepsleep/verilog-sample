/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			reset_proc2
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		reset_proc2
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
module reset_proc2 ( 
              //input 
              sys_clk,
              p_rst_n,


              //output 
              sys_rst_n
              );

//input ports

input                    sys_clk          ;   //system clock;
input                    p_rst_n          ;   //system port input reset, low is active;


//output ports
output [WIDTH-1:0]       sys_rst_n         ;   //output reset signal ,can be used directlty

//reg define 

reg    [WIDTH-1:0]       rst_p1            ;   //reset signal ,pre 1 cycle
reg    [WIDTH-1:0]       sys_rst_n         ;   //real reset signal 

                             
reg    [WIDTH-1:0]       p_rst_temp1       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp2       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp3       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp4       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp5       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp6       ;   //temp reg
reg    [WIDTH-1:0]       p_rst_temp7       ;   //temp reg

//wire define


//parameter define 
parameter WIDTH = 1;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk ) begin 
    p_rst_temp1 <= p_rst_n;
end
            
always @(posedge sys_clk ) begin 
    p_rst_temp2 <= p_rst_temp1;
end

always @(posedge sys_clk ) begin 
    p_rst_temp3 <= p_rst_temp2;
end

always @(posedge sys_clk ) begin 
    p_rst_temp4 <= p_rst_temp3;
end

always @(posedge sys_clk ) begin 
    p_rst_temp5 <= p_rst_temp4;
end

always @(posedge sys_clk ) begin 
    p_rst_temp6 <= p_rst_temp5;
end

always @(posedge sys_clk ) begin 
    p_rst_temp7 <= p_rst_temp6;
end
 
assign rst_temp = p_rst_temp1 | p_rst_temp2 | p_rst_temp3 | p_rst_temp4 | p_rst_temp5 | p_rst_temp6  | p_rst_temp7 ;     


always @(posedge sys_clk ) begin 
    sys_rst_n <= rst_temp;
end


endmodule
//end of RTL code                       