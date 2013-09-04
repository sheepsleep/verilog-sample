/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           divider4_5
** Last modified Date:  2009-12-18
** Last Version:        1.0
** Descriptions:        divider4_5
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-12-18
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
module divider4_5 ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              data_in        ,

              //output 
              clkout
              );


//parameter define 
parameter WIDTH = 10;
parameter SIZE  = 8;


//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;
input  [WIDTH-1:0]       data_in             ;    //input data 

//output ports
output                   clkout              ;

//reg define 
reg    [WIDTH-1:1]       count               ;

reg                      ps_count1           ;
reg                      ps_count5           ;
reg                      ps_count6           ;



//wire define 


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

/* Counter implementation, reset value : 9¡¯b000000001 */
always @( posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
       count[9:1] <= 9'b000000001   ;
    else if (count[9] == 1'b1) begin
       count[9:1] <=  9'b000000001  ;
    end
    else begin
       count[9:1] <= count[9:1] << 1;    
    end
end
/*count bit 1st, 5th and 6th phase shifter by 180o */
always @(negedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
       ps_count1 <= 1'b0;
       ps_count5 <= 1'b0;
       ps_count6 <= 1'b0;
    end
    else begin
       ps_count1 <= count[1];
       ps_count5 <= count[5];
       ps_count6 <= count[6];
    end
end

// generation of final output clock = (sys_clk /4.5)
assign clkout = (ps_count5 | ps_count6 | count[6]) |
                (count[1] | count[2] | ps_count1);

endmodule
//end of RTL code                       
