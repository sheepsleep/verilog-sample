/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           PLL
** Last modified Date:  2009-11-13
** Last Version:        1.0
** Descriptions:        PLL
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-11-13
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
module PLL_Inst ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,

              //output 
              clk_100M       ,
              clk_20M        ,
              clk_80M        
              // data_out 
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;


//output ports

output                   clk_100M            ;    //output clock 100M;  
output                   clk_20M             ;    //output clock 20M;  
output                   clk_80M             ;    //output clock 80M;  
//output                   clock_enbale        ;

//reg define 

//wire define 

wire                     clk_100M_tmp        ;    //wire clock 100M;  
wire                     clk_80M_tmp         ;    //wire clock 20M;  
wire                     clk_20M_tmp         ;    //wire clock 80M;  

wire                     clk_100M            ;    //wire clock 100M;  
wire                     clk_80M             ;    //wire clock 20M;  
wire                     clk_20M             ;    //wire clock 80M;  


//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

//instance the PLL
PLL   PLL_U0    (
	              .areset  (sys_rst_n        )             ,
	              .inclk0  (sys_clk          )             ,
	              .c0      (clk_100M_tmp     )             ,
	              .c1      (clk_20M_tmp      )             ,
	              .c2      (clk_80M_tmp      )             ,
	              .locked  (clock_enbale     )             
	              );


//enbale the clock when the pll is locked

assign clk_100M = (clock_enbale == 1'b1)? clk_100M_tmp : 1'b0;
assign clk_80M  = (clock_enbale == 1'b1)? clk_80M_tmp  : 1'b0;
assign clk_20M  = (clock_enbale == 1'b1)? clk_20M_tmp  : 1'b0;

endmodule
//end of RTL code                       