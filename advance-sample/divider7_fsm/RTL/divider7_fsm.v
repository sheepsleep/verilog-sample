/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           divider7_fsm
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        divider7_fsm
**------------------------------------------------------------------------------------------------------
** Created by:          divider7_fsm
** Created date:        2009-10-18
** Version:             1.0
** Descriptions:        The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module divider7_fsm ( 
              //input 
              sys_clk        ,                    // system clock;
              sys_rst_n      ,                    // system reset, low is active;

              //output 
              clk_divide_7                        // output divide 7 clk  
              );

//input ports
input                    sys_clk             ;    // system clock;
input                    sys_rst_n           ;    // system reset, low is active;

//output ports
output [WIDTH-1:0]       clk_divide_7        ;    // output divide 7 clk 

//reg define 
reg [6:0]                curr_st             ;    // FSM current state
reg [6:0]                next_st             ;    // FSM next    state

reg                      clk_divide_7        ;    // generated clock£¬divide by 7

//wire define 

//parameter define 
parameter WIDTH = 1;                              // WIDTH is the parameter of clk_divide_7 

//one hot code design
parameter S0 = 7'b0000000;
parameter S1 = 7'b0000001;
parameter S2 = 7'b0000010;
parameter S3 = 7'b0000100;
parameter S4 = 7'b0001000;
parameter S5 = 7'b0010000;
parameter S6 = 7'b0100000;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
//generate FSM next state
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            curr_st <= 7'b0;
        end
        else  begin 
            curr_st <= next_st;
        end
end

//FSM state logic 
always @(*) begin 
    case (curr_st) 
        S0: begin  
                next_st = S1;
            end
        S1: begin 
                next_st = S2;
            end
        S2: begin 
                next_st = S3;
            end
        S3: begin 
                next_st = S4;
            end
        S4: begin  
                next_st = S5;
            end
        S5: begin 
                next_st = S6;
            end
        S6: begin 
                next_st = S0;
            end
        default: next_st = S0;
    endcase
end

//control divide clock offset
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_divide_7 <= 1'b0;
        end
        else if ((curr_st == S0) | (curr_st == S1) | (curr_st == S2) | (curr_st == S3)) 
            clk_divide_7  <= 1'b0;
        else if ((curr_st == S4) | (curr_st == S5) | (curr_st == S6)) 
            clk_divide_7  <= 1'b1;   
        else
            ; 
end

endmodule
//end of RTL code                       
