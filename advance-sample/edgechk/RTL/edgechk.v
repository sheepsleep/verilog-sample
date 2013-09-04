/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			edgechk
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		edge check
**------------------------------------------------------------------------------------------------------
** Created by:		    dongdong
** Created date:		2009-10-18
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
module edgechk ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              ctrl_signal,

              //output 
              posedge_pulse,
              negedge_pulse,
              edge_pulse

              );

//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;
input                    ctrl_signal;

//output ports
output                   posedge_pulse;
output                   negedge_pulse;
output                   edge_pulse;
//reg define 

reg                      ctrl_signal_dly1;
reg                      ctrl_signal_dly2;

//wire define 

//parameter define 
parameter WIDTH = 7;


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            ctrl_signal_dly1 <= 1'b0;
            ctrl_signal_dly2 <= 1'b0;
        end
        else begin 
            ctrl_signal_dly1 <= ctrl_signal;
            ctrl_signal_dly2 <= ctrl_signal_dly1;
        end
end


assign posedge_pulse = (ctrl_signal_dly1 & (~ctrl_signal_dly2));

assign negedge_pulse = (~ctrl_signal_dly1) & ctrl_signal_dly2;

assign edge_pulse    = (ctrl_signal_dly1 ^ ctrl_signal_dly2);

endmodule
//end of RTL code                       