/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			 s2p
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:     \  s2p
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
module s2p ( 
              //input 
			  sys_clk,
		      sys_rst_n,
              shift_en,
              srial_data_in,

              //output 
              data_out
              );

//input ports

input                    sys_clk;             //system clock;
input                    sys_rst_n;           //system reset, low is active;
input                    shift_en;            //shift en signal
input                    srial_data_in;       //srial data in
//output ports
output  [WIDTH-1:0]      data_out;
//reg define 
 
reg  [WIDTH-1:0]         data_out;

//wire define 

wire                     shift_en;

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

integer   i;
/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)
        begin 
            data_out <= 8'b0;
        end
        else if (shift_en == 1'b1) begin
              for (i = 1'b0;i<WIDTH;i = i +1'b1)
                  data_out[i] <= srial_data_in;
        end
        else 
           data_out <= data_out;
          
end

endmodule
//end of RTL code                       