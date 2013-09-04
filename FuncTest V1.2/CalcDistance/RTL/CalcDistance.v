/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			CalcDistance
** Last modified Date:	2012-10-1
** Last Version:		1.0
** Descriptions:		Respond to the Key and send to theBeep
**------------------------------------------------------------------------------------------------------
** Created by:		    dongdong
** Created date:		2012-10-1
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
module CalcDistance( 
//input 
input                                          sys_clk        ,
input                                          sys_rst_n      ,
input                                          echo_vld       ,

//output 
output reg                                     trig_vld       ,

output wire   [7:0]                            LED
              );


//reg define 
reg    [ 9:0]                  trig_cnt          ;
reg    [25:0]                  cycle_cnt         ;

reg                            echo_vld_dly1     ;
reg                            echo_vld_dly2     ;
reg                            echo_vld_dly3     ;
reg                            echo_vld_dly4     ;

reg    [19:0]                  distance_cnt      ;



//parameter define 

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        trig_cnt <= 10'b0;
    else if ( cycle_cnt == 26'b0 ) 
        trig_cnt <= 10'b0;
    else if ( trig_cnt <= 10'd1023 ) 
        trig_cnt <= trig_cnt + 10'b1;
    else ;
end

// gen a  signal for cycle clear trig_cnt clear to 0 
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        cycle_cnt <= 26'b0;
    else  
        cycle_cnt <= cycle_cnt + 26'b1;
end

// gen trig vld by trig cnt 
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        trig_vld <= 1'b0;
    else if ( cycle_cnt >= 10'd1 && cycle_cnt <= 10'd1022 ) 
        trig_vld <= 1'b1;
    else 
        trig_vld <= 1'b0;
end

// gen trig vld by trig cnt 
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        echo_vld_dly1 <= 1'b0;
    else 
        echo_vld_dly1 <= echo_vld;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        echo_vld_dly2 <= 1'b0;
    else 
        echo_vld_dly2 <= echo_vld_dly1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        echo_vld_dly3 <= 1'b0;
    else 
        echo_vld_dly3 <= echo_vld_dly2;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        echo_vld_dly4 <= 1'b0;
    else 
        echo_vld_dly4 <= echo_vld_dly3;
end

// 1m = T*340/2 -> T is 5.88 ms 
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        distance_cnt <= 20'b0;
    else if ( echo_vld_dly3 == 1'b1 && echo_vld_dly4 == 1'b0 )
        distance_cnt <= 20'b0;
    else if ( echo_vld_dly3 == 1'b1 )
        distance_cnt <= distance_cnt + 20'b1;
    else ;
end

assign LED = distance_cnt[19:12] ;                //distance value display in led

endmodule
//end of RTL code                       