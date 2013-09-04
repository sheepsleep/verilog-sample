/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           SegLed_V2
** Last modified Date:  2012-12-18
** Last Version:        2.0
** Descriptions:        SegLed
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
** Descriptions:		  modify hc595 driver segled to 8550
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module SegLed_V2 ( 
//input 
input                    sys_clk        ,
input                    sys_rst_n      ,

//output 
output wire              seg_c1         ,
output wire              seg_c2         ,
output wire              seg_c3         ,
output wire              seg_c4         ,

output reg               seg_a          ,
output reg               seg_b          ,
output reg               seg_c          ,
output reg               seg_d          ,
output reg               seg_e          ,
output reg               seg_f          ,
output reg               seg_g          ,
output reg               seg_h          
				  
              );

//parameter define 
parameter WIDTH2 = 26;
parameter WIDTH = 5;
parameter SIZE  = 8;

//reg define 
reg    [3:0]             counter                ;
reg    [WIDTH2-1:0]      count                  ;
reg    [SIZE-1:0]        disp_data              ;

reg    [SIZE-1:0]        dat                    ;

reg                      disp_clk               ;

reg    [25:0]            clk_cnt                ;

reg                     segled_a          ;
reg                     segled_b          ;
reg                     segled_c          ;
reg                     segled_d          ;
reg                     segled_e          ;
reg                     segled_f          ;
reg                     segled_g          ;
reg                     segled_h          ;


//wire define 


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
 
// gen a counter for SEGLED counter, 1S = 50000000 * 20ns 
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if (sys_rst_n ==1'b0)  
       clk_cnt <= 26'b0;
   else if ( clk_cnt == 26'd50000000 )
       clk_cnt <= 26'b0;
	else
       clk_cnt <= clk_cnt + 26'b1;
end

// gen a SEGLED counter for control  SEGLED disp speed
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0)  
        counter <= 4'd0;
    else if ( clk_cnt == 26'd50000000 && counter == 4'd9 ) 
        counter <= 4'b0;
    else if ( clk_cnt == 26'd50000000 ) 
        counter <= counter + 4'b1;
	 else ;
end

// control  SEGLED disp 0-9				 
always @(*) begin 
    case (counter)
         9        :  
			            begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 0 ;   
								 segled_f = 1 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 
         8        :
                 		begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 1 ;   
								 segled_e = 1 ;   
								 segled_f = 1 ;   
			                segled_g = 1 ;   
								 segled_h = 1 ;   
			            end 
         7        :     
			            begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 0 ;   
								 segled_f = 0 ;   
			                segled_g = 0 ;   
								 segled_h = 0 ;   
			            end 
         6        :
			            begin
			                segled_a = 1 ;   
								 segled_b = 0 ;   
			                segled_c = 1 ;   
								 segled_d = 1 ;   
								 segled_e = 1 ;   
								 segled_f = 1 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 			
         5        :
			            begin
			                segled_a = 1 ;   
								 segled_b = 0 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 1 ;   
								 segled_f = 1 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 			
         4        :
			            begin
			                segled_a = 0 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 0 ;   
								 segled_f = 1 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 			
         3        :
			            begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 1 ;   
								 segled_f = 0 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 			
         2        : 
			            begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 0 ;   
								 segled_d = 1 ;   
								 segled_e = 1 ;   
								 segled_f = 0 ;   
			                segled_g = 1 ;   
								 segled_h = 0 ;   
			            end 			
         1        :
			            begin
			                segled_a = 0 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 0 ;   
								 segled_e = 0 ;   
								 segled_f = 0 ;   
			                segled_g = 0 ;   
								 segled_h = 0 ;   
			            end 			
         0        :  
			            begin
			                segled_a = 1 ;   
								 segled_b = 1 ;   
			                segled_c = 1 ;   
								 segled_d = 1 ;   
								 segled_e = 1 ;   
								 segled_f = 1 ;   
			                segled_g = 0 ;   
								 segled_h = 1 ;   
			            end 			
         default  :      
						   begin
			                segled_a = 0 ;   
								 segled_b = 0 ;   
			                segled_c = 0 ;   
								 segled_d = 0 ;   
								 segled_e = 0 ;   
								 segled_f = 0 ;   
			                segled_g = 0 ;   
								 segled_h = 0 ;   
			            end 
    endcase
end

// SEGLED is low active
always @(*) begin 
    seg_a = ~segled_a ;
    seg_b = ~segled_b ;
    seg_c = ~segled_c ;
    seg_d = ~segled_d ;
    seg_e = ~segled_e ;
    seg_f = ~segled_f ;
    seg_g = ~segled_g ;
    seg_h = ~segled_h ;
end

// four bit SEGLED disp at the same time
assign seg_c1 = 1'b0;
assign seg_c2 = 1'b0;
assign seg_c3 = 1'b0;
assign seg_c4 = 1'b0;

endmodule
//end of RTL code                       
