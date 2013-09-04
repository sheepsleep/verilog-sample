siy/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:	        TB.v
** Last modified Date:	2011-12-23
** Last Version:		1.0
** Descriptions:		
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:		2011-12-23
** Version:             1.0
** Descriptions:		The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:	  PWM TestBench
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/

module TB;

// declare input ports
reg                         sys_clk           ;  //system clock;
reg                         sys_rst_n         ;  //system reset, low is active;

initial begin
   sys_clk = 'b0       ;
   sys_rst_n = 'b1     ;
   #23  sys_rst_n = 'b0;
   #33  sys_rst_n = 'b1;
end

always #10 sys_clk = ~sys_clk;


SegLed   U_SegLed      (
                        //input ports
                        .osc_clk          ( sys_clk         )          ,
                        .sys_rst_n        ( sys_rst_n       )          ,
                                           
                        //output ports        

              .beep          (                 )   ,
              .seg_c1     (                 )    ,
              .seg_c2      (                 )   ,
              .seg_c3      (                 )   ,
              .seg_c4      (                 )   ,
              .hc595_data  (                 )   ,
              .hc595_cs    (                 )   ,
              .hc595_clk  (                 )

                        );
                        
                  


endmodule
