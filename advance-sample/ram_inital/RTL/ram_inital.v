/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           ram_inital
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        ram inital 
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
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
module ram_inital ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,

              //output 
              intial_en      ,         
              intial_addr
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;


//output ports
output                   intial_en           ;
output [WIDTH-1:0]       intial_addr         ;

//reg define 
reg    [WIDTH-1:0]       intial_addr         ;
reg    [SIZE-1:0]        intial_counter      ;    //intial counter used by gen inital addr

reg                      cfg_rst_n           ;    //cfg reset
reg                      intial_en           ;    //intial enable
//wire define 


//parameter define 
parameter WIDTH = 3;
parameter SIZE  = 4;

parameter inital_period  = 8;
parameter reset_period   = 10;
/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            intial_counter <= 4'b0;
        end
        else  
            intial_counter  <= intial_counter + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cfg_rst_n <= 1'b0;
        end
        else if (intial_counter < reset_period) 
            cfg_rst_n  <= 1'b0;
        else
            cfg_rst_n  <= 1'b1;
end


always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            intial_en <= 1'b1;
        end
        else if (intial_counter < inital_period) 
            intial_en  <= 1'b1;
        else
            intial_en  <= 1'b0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            intial_addr <= 'b0;
        end
        else if (intial_en == 1'b1) 
            intial_addr  <= intial_addr + 1'b1;
        else
            intial_addr  <= intial_addr;
end


endmodule
//end of RTL code                       