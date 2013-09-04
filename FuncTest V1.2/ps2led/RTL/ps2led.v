/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           ps2led
** Last modified Date:  2009-11-8
** Last Version:        1.0
** Descriptions:        ps2led
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-11-8
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
module ps2led ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              ps2_key_clk    ,
              ps2_key_data   ,
              
              clk_256        ,
              //output 
              data_out       ,
              LED
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;

input                    ps2_key_clk         ;    //ps2 beyboard clock;
input                    ps2_key_data        ;    //ps2 beyboard data ;


//output ports
output [WIDTH-1:0]       data_out            ;   // output KEY value,in hex format
output [WIDTH-1:0]       clk_256             ;   // for signaltap II debug use
output [WIDTH-1:0]       LED                 ;   // output led,in hex format
//reg define 

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

parameter WIDTH2 = 18;

parameter Para  = 50;

assign clk_50m = sys_clk ;


ps2key  ps2led_U0( 
              //input 
              .sys_clk        (clk_50m  )   ,
              .sys_rst_n      (sys_rst_n)   ,
              .ps2_key_clk    (ps2_key_clk) ,
              .ps2_key_data   (ps2_key_data),
              
              .clk_256        (   ),
              //output 
              .data_out       (   ),
              .led            (LED)  
              );

endmodule