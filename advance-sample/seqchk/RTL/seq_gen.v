/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			seqchk
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		gen sequtial signal
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
module seq_gen ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              seq_en,

              //output 
              seq_signal
              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input                    seq_en;

//output ports
output                   seq_signal;

//reg define 
reg [3:0]                counter;
reg                      seq_signal;

//wire define 

//parameter define 
parameter WIDTH = 7;


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            counter <= 3'b0;
        end
        else  if (seq_en == 1'b1)begin 
            counter <= counter + 1'b1;
        end
end


always @(*) begin 
    case (counter)
        3'b000: seq_signal = 1'b1;
        3'b001: seq_signal = 1'b1;
        3'b010: seq_signal = 1'b1;
        3'b011: seq_signal = 1'b0;
        3'b100: seq_signal = 1'b0;
        3'b101: seq_signal = 1'b1;
        3'b110: seq_signal = 1'b0;
        3'b111: seq_signal = 1'b0;
       default: seq_signal = 1'b0;
    endcase
end

endmodule
//end of RTL code                       