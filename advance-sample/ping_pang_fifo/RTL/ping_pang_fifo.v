/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			ping_pang_fifo
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		ping_pang_fifo
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
module ping_pang_fifo ( 
              //input 
              sys_clk,
              sys_rst_n,
              wr_data,
              wr_en,
              rd_en,
              //output 
              B1_full,
              B2_full,
              B1_empty,
              B2_empty,
              rd_data
              );

//input ports

input                    sys_clk        ;    //system clock;
input                    sys_rst_n      ;    //system reset, low is active;
input [7:0]              wr_data        ;
input                    wr_en          ;
input                    rd_en          ;

//output ports
output                   B1_full         ;
output                   B2_full         ;
output                   B1_empty        ;
output                   B2_empty        ;
output  [7:0]            rd_data         ;

//reg define 
reg    [WIDTH-1:0]       wr_addr         ;
reg    [WIDTH-1:0]       rd_addr         ;

reg                      wr_en_real      ;
reg                      rd_en_real      ;

reg                      B1_full         ;     
reg                      B2_full         ;     
reg                      B1_empty        ;     
reg                      B2_empty        ;     
reg                      rd_data         ;     



//wire define 


//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

//gen B1 full signal by compare address
always @(*) begin 
        if ((wr_addr >= 8'h0) && (wr_addr < 8'h80)) begin 
            B1_full <= 1'b1;
        end
        else 
            B1_full <= 1'b0;
end

//gen B2 full signal by compare address  
always @(*) begin 
        if ((wr_addr >= 8'h80) && (wr_addr <= 8'hff)) begin 
            B2_full <= 1'b1;
        end
        else 
            B2_full <= 1'b0;
end
    
always @(*) begin 
        if ((rd_addr >= 8'h0) && (rd_addr < 8'h80)) begin 
            B1_empty <= 1'b0;
        end
        else 
            B1_empty <= 1'b1;
end
  
always @(*) begin 
        if ((rd_addr >= 8'h80) && (rd_addr <= 8'hff)) begin 
            B2_empty <= 1'b0;
        end
        else 
            B2_empty <= 1'b1;
end    
    
//gen real wr_en_real signal by compare full and empty
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            wr_en_real <= 1'b0;
        end
        else if ((B1_full == 1'b0) && (B1_empty == 1'b1)) 
            wr_en_real  <= 1'b1;
        else if ((B2_full == 1'b0) && (B2_empty == 1'b1)) 
            wr_en_real  <= 1'b1;    
         else 
            wr_en_real  <= 1'b0;        
end  
 
//gen real rd_en_real signal by compare full and empty 
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            rd_en_real <= 1'b0;
        end
        else if ((B1_full == 1'b1) && (B1_empty == 1'b0)) 
            rd_en_real  <= 1'b1;
        else if ((B2_full == 1'b1) && (B2_empty == 1'b0)) 
            rd_en_real  <= 1'b1;    
         else 
            rd_en_real  <= 1'b0;        
end    
 
//gen write address  ,increase when en is acitive
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            wr_addr <= 8'b0;
        end
        else if (wr_en_real == 1'b1) 
            wr_addr  <= wr_addr + 1'b1;
end

//gen read address  
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            rd_addr <= 8'b0;
        end
        else if (rd_en_real == 1'b1) 
            rd_addr  <= rd_addr + 1'b1;
end



endmodule
//end of RTL code                       