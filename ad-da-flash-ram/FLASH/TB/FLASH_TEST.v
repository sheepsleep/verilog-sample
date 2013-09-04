/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           FLASH_TEST
** Last modified Date:  2012-10-2
** Last Version:        1.1
** Descriptions:        FLASH_TEST
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2012-10-2
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
module FLASH_TEST ( 
//input  
input               sys_clk            ,    //system clock;
input               sys_rst_n          ,    //system reset, low is active;

//output               

inout       [15:0]  FLASH_DQ            ,  
       
output reg  [20:0]  FLASH_ADDR          ,         

output reg          FLASH_CE            ,         
output reg          FLASH_OE            ,         
output reg          FLASH_WE            ,         
     
output reg          FLASH_RST           ,    
     
output reg  [ 7:0]  LED              

                   );

//Reg define 
reg    [3:0]             div_cnt             ;
reg                      flash_clk           ;

reg    [31:0]            wait_cnt            ;


reg    [5:0]             ctrl_cnt            ;

reg    [15:0]            flash_data_lck      ;

reg    [15:0]            flash_din          ;

//Wire define 


//************************************************************************************
//**                              Main Program    
//**  
//************************************************************************************

// counter used for div osc clk to flash ctrl clk  50M/16 , one flash ctrl clk cycle is 330ns
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        div_cnt <= 4'b0;
    else  
        div_cnt <= div_cnt + 4'b1;
end

//gen flash_clk
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
	     flash_clk <= 1'b0 ;
    else if ( div_cnt <= 4'd7 ) 
        flash_clk <= 1'b1 ;
    else  
        flash_clk <= 1'b0 ;
end

// flash ctrl signal gen 

// read FLASH devid need 5 step :

// ctrl_cnt  10 - 13 is write oxaa in addr 0x5555 
// ctrl_cnt  14 - 17 is write ox55 in addr 0x2aaa 
// ctrl_cnt  18 - 21 is write ox90 in addr 0x5555 

// ctrl_cnt  22 -30 is wait time for TIDA
// ctrl_cnt  31 -34 is read manId in addr 0
// ctrl_cnt  35 -38 is read devid in addr 1

// wait counter is used for wait FPGA is constanct
always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        wait_cnt <= 32'b0;
    else if ( wait_cnt < 32'hff )
        wait_cnt <= wait_cnt + 32'b1;
    else ;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        ctrl_cnt <= 6'b0;
    else if ( wait_cnt == 32'hff )
        ctrl_cnt <= ctrl_cnt + 6'b1;
    else ;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        FLASH_ADDR <= 21'b0;
    else if ( ctrl_cnt >= 6'd10 && ctrl_cnt <= 6'd13 )    // setp0
        FLASH_ADDR <= 21'h5555;
    else if ( ctrl_cnt >= 6'd14 && ctrl_cnt <= 6'd17 )    // setp1
        FLASH_ADDR <= 21'h2aaa;
    else if ( ctrl_cnt >= 6'd18 && ctrl_cnt <= 6'd21 )    // setp2
        FLASH_ADDR <= 21'h5555;
    else if ( ctrl_cnt >= 6'd31 && ctrl_cnt <= 6'd34 )    // setp3
        FLASH_ADDR <= 21'h0;
    else if ( ctrl_cnt >= 6'd35 && ctrl_cnt <= 6'd38 )    // setp4
        FLASH_ADDR <= 21'h1;
	 else 
	     FLASH_ADDR <= 21'b0;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        FLASH_CE <= 1'b1;
    else if ( ctrl_cnt >= 6'd10  && ctrl_cnt <= 6'd21)   // WRITE CE
        FLASH_CE <= 1'b0;
	 else if ( ctrl_cnt >= 6'd31  && ctrl_cnt <= 6'd38 )  // READ  CE
        FLASH_CE <= 1'b0;
	 else
	     FLASH_CE <= 1'b1;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        FLASH_OE <= 1'b1;
    else if ( ctrl_cnt >= 6'd31 && ctrl_cnt <= 6'd38 )  // READ OE
        FLASH_OE <= 1'b0;
	 else
	     FLASH_OE <= 1'b1;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        FLASH_WE <= 1'b1;
    else if ( ctrl_cnt == 6'd11 )   // WRITE WE
        FLASH_WE <= 1'b0;
    else if ( ctrl_cnt == 6'd15 )   // WRITE WE
        FLASH_WE <= 1'b0;
    else if ( ctrl_cnt == 6'd19 )   // WRITE WE
        FLASH_WE <= 1'b0;
	 else
	     FLASH_WE <= 1'b1;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        FLASH_RST <= 1'b1;
    else if ( ctrl_cnt == 6'd1 || ctrl_cnt == 6'd2 || ctrl_cnt == 6'd3 )  // RST
        FLASH_RST <= 1'b0;
	 else
	     FLASH_RST <= 1'b1;
end

always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        flash_din <= 16'b0;
    else if ( ctrl_cnt >= 6'd10 && ctrl_cnt <= 6'd13 )    // setp0
        flash_din <= 16'hAA;
    else if ( ctrl_cnt >= 6'd14 && ctrl_cnt <= 6'd17 )    // setp1
        flash_din <= 16'h55;
    else if ( ctrl_cnt >= 6'd18 && ctrl_cnt <= 6'd21 )    // setp2
        flash_din <= 16'h90;
	 else 
	     flash_din <= 16'b0;
end

 // LATCH FLASH READ return DEVID
always @(posedge flash_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        flash_data_lck <= 16'b0;
  //  else if ( ctrl_cnt == 6'd36 )         // ctrl_cnt == 6'd36 is DEVID data return time
    else if ( ctrl_cnt == 6'd32 )         // ctrl_cnt == 6'd36 is DEVID data return time
        flash_data_lck <= FLASH_DQ ;
	 else ;
end

assign FLASH_DQ = ( ctrl_cnt <= 6'd25 ) ?  flash_din : 16'hZZZZ ;

always @( * ) begin 
    LED[0] = flash_data_lck[0]  ;
    LED[1] = flash_data_lck[1]  ;
    LED[2] = flash_data_lck[2] ;
    LED[3] = flash_data_lck[3] ;
	 LED[4] = flash_data_lck[4] ;
    LED[5] = flash_data_lck[5] ;
    LED[6] = flash_data_lck[6] ;
    LED[7] = flash_data_lck[7] ;
end

endmodule
//end of RTL code       