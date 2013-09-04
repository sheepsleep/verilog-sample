/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			  lookup
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		lookup
**------------------------------------------------------------------------------------------------------
** Created by:		  dongdong
** Created date:		2009-10-18
** Version:				  1.0
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
module lookup ( 
              //input 
              sys_clk,
              sys_rst_n,
              a,
              b,
              //output 
              out
              );

//input ports
input                   sys_clk                   ;      //system clock;
input                   sys_rst_n                 ;      //system reset, low is active;
input  [WIDTH-1:0]      a                         ;      //mult input a 
input  [WIDTH-1:0]      b                         ;      //mult input b  

//output ports
output [SIZE-1:0]       out                        ;

//reg define 


reg    [SIZE-1:0]       out                        ;
//wire define 
wire   [3:0]            address                    ;

//parameter define 
parameter WIDTH = 2;
parameter SIZE  = 4;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

assign address = {a,b};

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            out <= 4'b0;
        end
        else begin
            case (address)
                4'h0 : out = 4'b0000    ;
                4'h1 : out = 4'b0000    ;
                4'h2 : out = 4'b0000    ;
                4'h3 : out = 4'b0000    ;
                4'h4 : out = 4'b0000    ;
                4'h5 : out = 4'b0001    ;
                4'h6 : out = 4'b0010    ;
                4'h7 : out = 4'b0011    ;
                4'h8 : out = 4'b0000    ;
                4'h9 : out = 4'b0010    ;
                4'ha : out = 4'b0100    ;
                4'hb : out = 4'b0110    ;
                4'hc : out = 4'b0000    ;
                4'hd : out = 4'b0011    ;
                4'he : out = 4'b0110    ;
                4'hf : out = 4'b1001    ;
                default : out='bx;
            endcase
        end
end

endmodule
//end of RTL code                       