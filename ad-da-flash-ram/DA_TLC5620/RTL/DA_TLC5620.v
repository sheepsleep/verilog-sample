/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           DA_TLC5620
** Last modified Date:  2012-10-8
** Last Version:        1.1
** Descriptions:        DA_TLC5620
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2012-10-8
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
module DA_TLC5620 ( 
                  //input 
input             sys_clk             ,    //system clock;
input             sys_rst_n           ,    //system reset, low is active;

                  //output 
output reg        DA_IO_CLK           ,     
output reg        DA_LOAD             ,   
output reg        DA_LDAC             ,  
output reg        DA_OUT_DATA         ,    

output reg [7:0]  LED                 
              );

//Reg define 
reg    [6:0]             div_cnt             ;
reg                      da_clk              ;

reg    [4:0]             ctrl_cnt            ;

reg    [15:0]            delay_cnt           ;

reg    [ 7:0]            analog_data         ;

//Wire define 


//************************************************************************************
//**                              Main Program    
//**  
//************************************************************************************


// counter used for div osc clk to da ctrl clk  50M/64 = 0.78Mhz
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        div_cnt <= 6'b0;
    else  
        div_cnt <= div_cnt + 6'b1;
end

//gen da_clk
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
	     da_clk <= 1'b0 ;
    else if ( div_cnt <= 6'd31 ) 
        da_clk <= 1'b1 ;
    else  
        da_clk <= 1'b0 ;
end

// da ctrl signal gen 
// ctrl_cnt  0 - 32 is for da ctrl

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        ctrl_cnt <= 5'b0;
    else  
        ctrl_cnt <= ctrl_cnt + 5'b1;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        DA_IO_CLK <= 1'b0;
    else if (  ctrl_cnt == 5'd6  || ctrl_cnt == 5'd8  || ctrl_cnt == 5'd10
            || ctrl_cnt == 5'd12 || ctrl_cnt == 5'd14 || ctrl_cnt == 5'd16 
            || ctrl_cnt == 5'd18 || ctrl_cnt == 5'd20 || ctrl_cnt == 5'd22 
				|| ctrl_cnt == 5'd24	|| ctrl_cnt == 5'd26 )  // DA clk low
        DA_IO_CLK <= 1'b1;
	 else
	     DA_IO_CLK <= 1'b0;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        DA_LOAD <= 1'b1;
    else if ( ctrl_cnt == 5'd28 )  // da load
        DA_LOAD <= 1'b0;
	 else
	     DA_LOAD <= 1'b1;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        DA_LDAC <= 1'b1;
    else if ( ctrl_cnt == 5'd30 )  // da load
        DA_LDAC <= 1'b0;
	 else
	     DA_LDAC <= 1'b1;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        DA_OUT_DATA <= 1'b0;
    else if ( ctrl_cnt == 5'd6 || ctrl_cnt == 5'd7 )  // da load A1 
        DA_OUT_DATA <= 1'b0;
    else if ( ctrl_cnt == 5'd8 || ctrl_cnt == 5'd9 )  // da load A0 
        DA_OUT_DATA <= 1'b0;
    else if ( ctrl_cnt == 5'd10 || ctrl_cnt == 5'd11 )  // da load RNG 
        DA_OUT_DATA <= 1'b0;
    else if ( ctrl_cnt == 5'd12 || ctrl_cnt == 5'd13 )  // da load analog_data BIT[7] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd14 || ctrl_cnt == 5'd15 )  // da load analog_data BIT[6] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd16 || ctrl_cnt == 5'd17 )  // da load analog_data BIT[5] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd18 || ctrl_cnt == 5'd19 )  // da load analog_data BIT[4] 
        DA_OUT_DATA <= analog_data[7];    
	 else if ( ctrl_cnt == 5'd20 || ctrl_cnt == 5'd21 )  // da load analog_data BIT[3] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd22 || ctrl_cnt == 5'd23 )  // da load analog_data BIT[2] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd24 || ctrl_cnt == 5'd25 )  // da load analog_data BIT[1] 
        DA_OUT_DATA <= analog_data[7];
    else if ( ctrl_cnt == 5'd26 || ctrl_cnt == 5'd27 )  // da load analog_data BIT[0] 
        DA_OUT_DATA <= analog_data[7];
	 else
	     DA_OUT_DATA <= 1'b0;;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        delay_cnt <= 16'b0;
    else  
        delay_cnt <= delay_cnt + 16'b1;
end

always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        analog_data <= 8'b0;
    else if ( delay_cnt == 16'hffff )
        analog_data <= analog_data + 8'b1;
	 else ;
end

//display DA sample data to LED
always @(posedge da_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        LED <= 8'b0;
    else
        LED <= analog_data ;
end

endmodule
//end of RTL code                       