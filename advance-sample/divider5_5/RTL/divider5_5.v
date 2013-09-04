/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			  divider5_5
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		divider5_5
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

module divider5_5 ( 
                   //input 
			             sys_clk,
		               sys_rst_n,

                   //output 
                   clkout
                   );
 
//input ports

input                    sys_clk;      //system clock;
input                    sys_rst_n;    //system reset, low is active;


//output ports
output                   clkout;


//reg define 

reg    [2:0]             counter;

reg                      clkout;
reg                      clk_2;
//wire define 
wire                     sys_clk;
wire                     clk_real;

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

assign clk_real = sys_clk ^ clk_2;             //

always @(posedge clk_real  or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            counter <= 3'b0;
        end
        else if (counter == 5 ) begin 
                counter <= 3'b0;
        end
        else
                counter <= counter + 3'b1;
       
end

always @(posedge clk_real or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clkout <= 1'b0;
        end
        else if ((counter == 3'b000) || (counter == 3'b001))
            clkout <= ~clkout;
end


always @(posedge clkout or negedge sys_rst_n ) begin
        if (sys_rst_n == 1'b0 ) 
            clk_2  <= 1'b0;
        else 
            clk_2  <= ~clk_2 ;
end

endmodule

