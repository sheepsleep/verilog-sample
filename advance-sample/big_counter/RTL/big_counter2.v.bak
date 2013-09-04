/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           big_counter
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        big_counter
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
module big_counter ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              data_in        ,

              //output 
              counter       
             //counter1
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;
input  [WIDTH-1:0]       data_in             ;    //input data 

//output ports
output [WIDTH-1:0]       counter            ;

//output [WIDTH-1:0]       counter1           ;

//reg define 
reg    [7:0]             cnt0                ;
reg    [7:0]             cnt1                ;
reg    [7:0]             cnt2                ;


reg    [8:0]             cnt00                ;
reg    [8:0]             cnt11                ;
reg    [8:0]             cnt22                ;


reg    [7:0]             cnt00_dly1                ;
reg    [7:0]             cnt00_dly2                ;

reg    [7:0]             cnt11_dly1                ;


//wire define 
wire   [WIDTH-1:0]       counter             ;

wire   [WIDTH-1:0]       counter1             ;

wire   [7:0]             temp00               ;      
wire   [7:0]             temp11               ;      
wire   [7:0]             temp22               ;      





//parameter define 
parameter WIDTH = 24;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt0 <= 8'b0;
        end
        else  
            cnt0  <= cnt0 + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt1 <= 8'b0;
        end
        else if (cnt0 == 8'hff) 
            cnt1  <= cnt1 + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt2 <= 8'b0;
        end
        else if ((cnt1 == 8'hff) && ((cnt0 == 8'hff)))  
            cnt2  <= cnt2 + 1'b1;
end

assign counter = {cnt2,cnt1,cnt0}  ;




endmodule
//end of RTL code                       