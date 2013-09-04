/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			seqchk
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		check sequtial signal
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
module seqchk ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              seq_en,

              //output 
              led
              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input                    seq_en;

//output ports
output                   led;

//reg define 
reg [6:0]                curr_st;
reg [6:0]                next_st;

reg                      led;
//wire define 
wire                     seq_signal;
//parameter define 
parameter WIDTH = 7;

parameter S0 = 7'b0000000;
parameter S1 = 7'b0000001;
parameter S2 = 7'b0000010;
parameter S3 = 7'b0000100;
parameter S4 = 7'b0001000;
parameter S5 = 7'b0010000;
parameter S6 = 7'b0100000;
parameter S7 = 7'b1000000;



/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

seq_gen u_seq_gen 
                (		
            	.sys_clk    (sys_clk   ),
		        .sys_rst_n  (sys_rst_n ),
                .seq_en     (seq_en    ),
                .seq_signal (seq_signal)
                );


always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            curr_st <= 7'b0;
        end
        else  begin 
            curr_st <= next_st;
        end
end

always @(*) begin 
    case (curr_st) 
        S0: begin 
            if (seq_signal == 1'b1) 
                next_st = S1;
            else 
                next_st = S0;
            end
        S1: begin 
            if (seq_signal == 1'b1) 
                next_st = S2;
            else 
                next_st = S0;
            end
        S2: begin 
            if (seq_signal == 1'b1) 
                next_st = S3;
            else 
                next_st = S0;
            end
        S3: begin 
            if (seq_signal == 1'b0) 
                next_st = S4;
            else 
                next_st = S3;
            end
        S4: begin 
            if (seq_signal == 1'b0) 
                next_st = S5;
            else 
                next_st = S1;
            end
        S5: begin 
            if (seq_signal == 1'b1) 
                next_st = S6;
            else 
                next_st = S0;
            end
        S6: begin 
            if (seq_signal == 1'b0) 
                next_st = S7;
            else 
                next_st = S2;
            end
        S7: begin 
            if (seq_signal == 1'b0) 
                next_st = S0;
            else 
                next_st = S1;
            end
        default: next_st = S0;
    endcase
end

//out put to the led ,low is active
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            led <= 1'b1;
        end
        else  if (curr_st == S7) begin 
            led <= 1'b0;
        end

end

endmodule
//end of RTL code                       