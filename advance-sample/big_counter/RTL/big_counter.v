/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           big_counter
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        big_counter
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-10-18
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
/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           big_counter
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        big_counter
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-10-18
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
module big_counter ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              data_in        ,

              //output 
              //counter        ,
              counter1
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;
input  [WIDTH-1:0]       data_in             ;    //input data 

//output ports
//output [WIDTH-1:0]       counter            ;

output [WIDTH-1:0]       counter1           ;

//reg define 
reg    [7:0]             cnt0                ;
reg    [7:0]             cnt1                ;
reg    [7:0]             cnt2                ;


reg    [8:0]             cnt00                ;
reg    [8:0]             cnt11                ;
reg    [8:0]             cnt22                ;


reg    [7:0]             cnt00_dly1                ;
reg    [7:0]             cnt00_dly2                ;

reg    [7:0]             cnt11_dly1                ;


//wire define 
wire   [WIDTH-1:0]       counter             ;

wire   [WIDTH-1:0]       counter1             ;

wire   [7:0]             temp00               ;      
wire   [7:0]             temp11               ;      
wire   [7:0]             temp22               ;      





//parameter define 
parameter WIDTH = 24;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt00 <= 8'b0;
        end
        else  
            cnt00  <= temp00 + 1'b1;
end

assign temp00 = cnt00[7:0];

assign c0 = cnt00[8];

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt11 <= 8'b0;
        end
        else  
            cnt11  <= temp11 + c0;
end

assign temp11 = cnt11[7:0];
assign c1 = cnt11[8];



always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            cnt22 <= 8'b0;
        end
        else  
            cnt22  <= temp22 + c1;
end

assign temp22 = cnt22[7:0];

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
        	  cnt00_dly1[7:0] <= 8'b0;
            cnt00_dly2[7:0] <= 8'b0;
        end
        else  
            cnt00_dly1[7:0]  <= cnt00[7:0]     ;        
            cnt00_dly2[7:0]  <= cnt00_dly1[7:0];
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
        	  cnt11_dly1[7:0] <= 8'b0;
        end
        else  
            cnt11_dly1[7:0]  <= cnt11[7:0]     ;        
end

assign counter1 = {cnt22[7:0],cnt11_dly1[7:0],cnt00_dly2[7:0]};

endmodule
//end of RTL code                                         