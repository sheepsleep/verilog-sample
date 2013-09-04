/****************************************Copyright (c)**************************************************
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
reg    [3:0]                key               ;

initial begin
   sys_clk = 'b0       ;
   sys_rst_n = 'b1     ;
   #23  sys_rst_n = 'b0;
   #33  sys_rst_n = 'b1;
end

always #10 sys_clk = ~sys_clk;

initial begin
               key  =  4'b1111          ;
   #10000    key =   4'b1000          ;
   #10000    key =   4'b1010          ;
   #10000    key =   4'b0110          ;
   #10000    key =   4'b1111          ;
end

PWM   PWM_U0      (
                        //input ports
                        .sys_clk          ( sys_clk         )          ,
                        .key              ( key             )          ,
                                           
                        //output ports        
                        .led              (                 )          ,    
                        .moto_a           (                 )          ,
                        .moto_b           (                 )        

                        );
                        
                  


endmodule
