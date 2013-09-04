/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           SegLed_DynamDisp
** Last modified Date:  2013-05-19
** Last Version:        2.0
** Descriptions:        SegLed_DynamDisp
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2013-05-19
** Version:             1.0
** Descriptions:        The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		  SegLed Dynamic Disp (base 8550)
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module SegLed_DynamDisp ( 
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
reg    [ 3:0]            disp_data              ;

reg    [SIZE-1:0]        dat                    ;

reg                      disp_clk               ;

reg    [25:0]            clk_cnt                ;

reg    [15:0]            scan_cnt                ;
reg    [ 3:0]            segled_bit_sel          ;


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
 
// gen scan SegLED counter, 1ms scan time
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if (sys_rst_n ==1'b0)  
       scan_cnt <= 16'b0;
   else 
	    scan_cnt <= scan_cnt + 16'b1;
end

//  gen segled bit sel by cnt high 2 bit
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if (sys_rst_n ==1'b0)  
       segled_bit_sel <= 4'b0001;
	else if ( scan_cnt[15:14] == 2'b00 )
       segled_bit_sel <= 4'b0001;
   else if ( scan_cnt[15:14] == 2'b01 )
       segled_bit_sel <= 4'b0010;
	else if ( scan_cnt[15:14] == 2'b10 )
       segled_bit_sel <= 4'b0100;
   else if ( scan_cnt[15:14] == 2'b11 )
       segled_bit_sel <= 4'b1000;		 
   else ;
end
 
// clk cnt for DISP data increase
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if (sys_rst_n ==1'b0)  
       clk_cnt <= 26'b0;
   else if ( clk_cnt == 26'd50000000 )
       clk_cnt <= 26'b0;
	else
       clk_cnt <= clk_cnt + 26'b1;
end
    
// DISP data increase from 0-9
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (sys_rst_n ==1'b0)  
        counter <= 4'd0;
    else if ( clk_cnt == 26'd50000000 && counter == 4'd9 ) 
        counter <= 4'b0;
    else if ( clk_cnt == 26'd50000000 ) 
        counter <= counter + 4'b1;
	 else ;
end

// sel dsip 4 bit data	
always @(*) begin 
    if ( segled_bit_sel == 4'b0001 ) 
        disp_data =  counter + 4'd1 ;
    else if ( segled_bit_sel == 4'b0010 ) 
        disp_data = counter + 4'd2 ;
    else if (segled_bit_sel == 4'b0100 ) 
        disp_data = counter + 4'd3 ;
	 else 
        disp_data = counter + 4'd4 ;	 
end

// SEGLED decode from disp data			
always @(*) begin 
    case (disp_data)
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

// assign seg , low active
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

// assign bit sel to SEGLED pin, low active
assign seg_c1 = ~( segled_bit_sel == 4'b0001 );
assign seg_c2 = ~( segled_bit_sel == 4'b0010 );
assign seg_c3 = ~( segled_bit_sel == 4'b0100 );
assign seg_c4 = ~( segled_bit_sel == 4'b1000 );

endmodule
//end of RTL code                       
