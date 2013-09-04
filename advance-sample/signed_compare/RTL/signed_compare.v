/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           signed_compare
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        signed_compare
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
module signed_compare ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              a1             ,
              b1             ,  
              a2             ,                
              b2             ,                
                          
              //output 
              c1             ,
              c2
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;

input [WIDTH-1:0]        a1                   ;    // signed input number ;
input [WIDTH-1:0]        b1                   ;    // signed input number ;
 
input [WIDTH-1:0]        a2                   ;    // signed input number ;
input [WIDTH-1:0]        b2                   ;    // signed input number ;

 
//output ports
output                   c1                   ;   //compare label, a>b c= 1 : a<b c= 0
output                   c2                   ;   //compare label, a>b c= 1 : a<b c= 0
//reg define 
reg                      c1                   ;   //compare label, a>b c= 1 : a<b c= 0
reg                      c2                   ;   //compare label, a>b c= 1 : a<b c= 0
//wire define 

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            c1 <= 1'b0;
        end
        else if (a1[7] == 1'b1) begin
             if (b1[7] == 1'b0) 
                c1 <= 1'b0; 
             else if (a1[6:0] > b1[6:0])
                c1 <= 1'b1;
             else
                c1 <= 1'b0;  
        end
        else begin 
            if (b1[7] == 1'b1)     
               c1 <= 1'b1;
            else if (a1[6:0] > b1[6:0])
               c1 <= 1'b1;    
            else
               c1 <= 1'b0;     
        end                    
                
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            c2 <= 1'b0;
        end
        else if ({~a2[7],a2[6:0]} > {~b2[7],b2[6:0]} ) begin
            c2 <= 1'b1;   
        end
        else
            c2 <= 1'b0;                   
                
end

endmodule
//end of RTL code                       