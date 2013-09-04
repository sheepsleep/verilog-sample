/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			  lookup_mult
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		lookup_mult
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
module lookup_mult ( 
              //input 
              sys_clk,
              sys_rst_n,
              a,
              b,
              //output 
              out
              );

//input ports
input                   sys_clk                   ;      //system clock;
input                   sys_rst_n                 ;      //system reset, low is active;
input  [WIDTH-1:0]      a                         ;      //mult input a 
input  [WIDTH-1:0]      b                         ;      //mult input b  

//output ports
output [SIZE-1:0]       out                        ;

//reg define 
reg    [7:0]            out                        ;      //mult result         
reg    [1:0]            firsta                     ;
reg    [1:0]            firstb                     ;     
reg    [1:0]            seconda                    ;
reg    [1:0]            secondb                    ; 

//wire define 

wire  [3:0]             outa                       ;      
wire  [3:0]             outb                       ;  
wire  [3:0]             outc                       ;  
wire  [3:0]             outd                       ;  

//parameter define 
parameter WIDTH = 4;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            firsta <= 2'b0;
        end
        else  
            firsta  <= a[3:2];
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            seconda <= 2'b0;
        end
        else  
            seconda  <= a[1:0];
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            firstb <= 2'b0;
        end
        else  
            firstb  <= b[3:2];
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            secondb <= 2'b0;
        end
        else  
            secondb  <= b[1:0];
end


//例化第一个查找表
lookup LOOK_UP_U0 (
                   .sys_clk   ( clk        )  ,
                   .sys_rst_n ( sys_rst_n  )  ,
                   .out       ( outa       )  ,
                   .a         ( firsta     )  ,
                   .b         ( firstb     )  
                   );

//例化第二个查找表
lookup LOOK_UP_U1 (
                   .sys_clk   ( clk        )  ,
                   .sys_rst_n ( sys_rst_n  )  ,
                   .out       ( outb       )  ,
                   .a         ( firsta     )  ,
                   .b         ( secondb    )  
                   );
                   
//例化第三个查找表                   
lookup LOOK_UP_U2 (
                   .sys_clk   ( clk        )  ,
                   .sys_rst_n ( sys_rst_n  )  ,
                   .out       ( outc       )  ,
                   .a         ( seconda    )  ,
                   .b         ( firstb     )  
                   );
                   
//例化第四个查找表                   
lookup LOOK_UP_U3 (
                   .sys_clk   ( clk        )  ,
                   .sys_rst_n ( sys_rst_n  )  ,
                   .out       ( outd       )  ,
                   .a         ( seconda    )  ,
                   .b         ( secondb    )  
                   );

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            out <= 8'b0;
        end
        else  
            out <= (outa << 4) + (outb << 2) + (outc << 2) + outd;
end

endmodule
//end of RTL code                       