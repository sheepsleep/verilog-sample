/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:	        TB.v
** Last modified Date:	2011-09-18
** Last Version:		1.0
** Descriptions:		TB.v
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2011-09-18
** Version:             1.0
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

module TB;

// declare input ports
reg                         sys_clk           ;  //system clock;
reg                         sys_rst_n         ;  //system reset, low is active;

reg                         sd_dout           ;


initial begin
   sys_clk = 'b0;
   sys_rst_n = 'b1;
   #43  sys_rst_n = 'b0;
   #63  sys_rst_n = 'b1;
end

always #10 sys_clk = ~sys_clk;


sdr_tb sdr_tb(

.sys_clk  (sys_clk)   ,                        // SYS CLK, 50Mhz
.sys_rst_n(sys_rst_n)                          

);
  

endmodule
