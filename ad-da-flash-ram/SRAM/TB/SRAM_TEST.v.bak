/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           SRAM_TEST
** Last modified Date:  2012-10-2
** Last Version:        1.1
** Descriptions:        SRAM_TEST
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
module SRAM_TEST ( 
//input  
input               sys_clk            ,    //system clock;
input               sys_rst_n          ,    //system reset, low is active;

//output               

inout       [15:0]  SRAM_DQ            ,  
       
output reg  [17:0]  SRAM_ADDR          ,         

output reg          SRAM_CE            ,         
output reg          SRAM_OE            ,         
output reg          SRAM_WE            ,         
output reg          SRAM_UB            ,         
output reg          SRAM_LB            ,    
     
output reg  [ 7:0]  LED              

                   );

//Reg define 
reg    [3:0]             div_cnt             ;
reg                      sram_clk            ;

reg    [5:0]             ctrl_cnt            ;

reg    [15:0]            sram_data_lck       ;


//Wire define 


//************************************************************************************
//**                              Main Program    
//**  
//************************************************************************************

// counter used for div osc clk to sram ctrl clk  50M/16 
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        div_cnt <= 4'b0;
    else  
        div_cnt <= div_cnt + 4'b1;
end

//gen sram_clk
always @(*) begin 
    if ( div_cnt <= 4'd7 ) 
        sram_clk <= 1'b1 ;
    else  
        sram_clk <= 1'b0 ;
end

// sram ctrl signal gen 
// ctrl_cnt  0 - 31 is for write ctrl
// ctrl_cnt 31 - 63 is for read ctrl
always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        ctrl_cnt <= 6'b0;
    else  
        ctrl_cnt <= ctrl_cnt + 6'b1;
end

always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        SRAM_ADDR <= 18'b0;
    else if ( ctrl_cnt == 6'd63 )
        SRAM_ADDR <= SRAM_ADDR + 18'b1;
	 else ;
end

always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        SRAM_CE <= 1'b1;
    else if ( ctrl_cnt <= 6'd20  && ctrl_cnt >= 6'd10 )  // WRITE CE
        SRAM_CE <= 1'b0;
	 else if ( ctrl_cnt <= 6'd40  && ctrl_cnt >= 6'd50 )  // READ  CE
        SRAM_CE <= 1'b0;
	 else
	     SRAM_CE <= 1'b1;
end

always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        SRAM_WE <= 1'b1;
    else if ( ctrl_cnt <= 6'd20  && ctrl_cnt >= 6'd10 )  // WRITE WE
        SRAM_WE <= 1'b0;
	 else
	     SRAM_WE <= 1'b1;
end

always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) begin
        SRAM_UB <= 1'b1;
		  SRAM_LB <= 1'b1;
    end
    else if ( ctrl_cnt <= 6'd20  && ctrl_cnt >= 6'd10 ) begin // WRITE U/L B
        SRAM_UB <= 1'b0;
		  SRAM_LB <= 1'b0;
    end
	 else if ( ctrl_cnt <= 6'd50  && ctrl_cnt >= 6'd40 ) begin // READ  U/L B
        SRAM_UB <= 1'b0;
		  SRAM_LB <= 1'b0;
    end
	 else begin
	     SRAM_UB <= 1'b1;
		  SRAM_LB <= 1'b1;
    end
end

always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        SRAM_OE <= 1'b1;
    else if (ctrl_cnt <= 6'd50  && ctrl_cnt >= 6'd40 )  // READ OE
        SRAM_OE <= 1'b0;
	 else
	     SRAM_OE <= 1'b1;
end

 // LATCH SRAM READ return DATA
always @(posedge sram_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0) 
        sram_data_lck <= 16'b0;
    else if ( ctrl_cnt == 6'd45 )         // ctrl_cnt == 6'd45 is data return time
        sram_data_lck <= SRAM_DQ ;
	 else ;
end

assign SRAM_DQ = ( ctrl_cnt <= 6'd31 ) ?  16'h5555 : 16'hxxxx ;

always @( * ) begin 
    LED[0] = sram_data_lck[0] & sram_data_lck[8]  ;
    LED[1] = sram_data_lck[1] | sram_data_lck[9]  ;
    LED[2] = sram_data_lck[2] & sram_data_lck[10] ;
    LED[3] = sram_data_lck[3] | sram_data_lck[11] ;
	 LED[4] = sram_data_lck[4] & sram_data_lck[12] ;
    LED[5] = sram_data_lck[5] | sram_data_lck[13] ;
    LED[6] = sram_data_lck[6] | sram_data_lck[14] ;
    LED[7] = sram_data_lck[7] | sram_data_lck[15] ;
end

endmodule
//end of RTL code                       