/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:       divider1.5
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		divider1_5
**------------------------------------------------------------------------------------------------------
** Created by:      dongdong
** Created date:		2009-10-18
** Version:         1.0
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
module divider1_5 ( 
              //input 
              sys_clk,
              sys_rst_n,


              //output 
              clk_divider1_5

              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;


//output ports
output                   clk_divider1_5;


//reg define 

reg    [1:0]             counter;

reg                      sigal_b;
reg                      sigal_c;

reg                      clk_divider1_5;

//wire define 

wire                     clk_divider3;
wire                     sys_clk_tmp ;
//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            counter <= 2'd0;
        end
        else if (counter == 2'd2) begin
            counter <= 2'd0;
        end
        else
            counter  <= counter +2'd1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            sigal_b <= 1'b0;
        end
        else if ((counter <= 2'd1) && (counter >= 2'd0))
            sigal_b  <= 1'b1;
        else 
            sigal_b  <= 1'b0;
end

always @(negedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            sigal_c <= 1'b0;
        end
        else 
            sigal_c  <= sigal_b;
end

assign clk_divider3 = sigal_b & sigal_c;

//when the clk_divider3 is hign ,select the sys_clk, else  select the neg_sys_clk
assign sys_clk_tmp = (clk_divider3 == 1'b1)? sys_clk : (~sys_clk);

//gen the clk_divider1_5 clock;
always @(negedge sys_clk_tmp or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_divider1_5 <= 1'b1;
        end
        else 
            clk_divider1_5  <= 1'b1;
end

endmodule
//end of RTL code                       