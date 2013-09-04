/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			crc_8
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		cal crc base 8 bit data
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
module crc_8(
             //input 
             sys_clk,
             sys_rst_n,
             data,
             calc,
             init,
             data_valid,
             //output 
             crc_reg,
             crc
             );


//input ports
input [7:0]                    data            ;
input                          calc            ;
input                          init            ;
input                          data_valid      ;
input                          sys_clk         ;
input                          sys_rst_n       ; 

//output ports 
output [15:0]                  crc_reg         ;
output [7:0]                   crc             ;

//reg define 
reg    [15:0]                  crc_reg         ;
reg    [7:0]                   crc             ;
                                            
//wire define                               
wire   [15:0]                  next_crc        ;

/******************************************************************************
**                              Main Program    
**  
*******************************************************************************/

always @(posedge sys_clk or posedge sys_rst_n) begin
    if (sys_rst_n) begin
       crc_reg <= 16'h0000;
       crc <= 8'h00;
    end
    else if (init)
        begin
        crc_reg <= 16'h0000 ;
        crc     <= 8'h00    ;
        end
    else if (calc & data_valid)
        begin
        crc_reg <= next_crc;
        crc <= ~{next_crc[8], next_crc[9], next_crc[10], next_crc[11],
        next_crc[12], next_crc[13], next_crc[14], next_crc[15]};
        end
    else if (~calc & data_valid)
        begin
        crc_reg <= {crc_reg[7:0], 8'h00};
        crc     <= ~{crc_reg[0], crc_reg[1], crc_reg[2], crc_reg[3],
                    crc_reg[4], crc_reg[5], crc_reg[6], crc_reg[7]};
        end
end

assign next_crc[0]  = crc_reg[12] ^ data[7] ^ crc_reg[8] ^ data[3];
assign next_crc[1]  = crc_reg[13] ^ data[6] ^ data[2] ^ crc_reg[9];
assign next_crc[2]  = data[5] ^ crc_reg[14] ^ data[1] ^ crc_reg[10];
assign next_crc[3]  = data[4] ^ crc_reg[15] ^ data[0] ^ crc_reg[11];
assign next_crc[4]  = crc_reg[12] ^ data[3];
assign next_crc[5]  = crc_reg[12]^crc_reg[13]^data[7]^crc_reg[8]^data[2]^data[3];
assign next_crc[6]  = crc_reg[13] ^ data[6] ^ crc_reg[14] ^ data[1] ^ data[2] ^ crc_reg[9];
assign next_crc[7]  = data[5] ^ crc_reg[14] ^ crc_reg[15] ^ data[0] ^ data[1] ^ crc_reg[10];
assign next_crc[8]  = data[4] ^ crc_reg[15] ^ data[0] ^ crc_reg[0] ^ crc_reg[11];
assign next_crc[9]  = crc_reg[12] ^ crc_reg[1] ^ data[3];
assign next_crc[10] = crc_reg[13] ^ data[2] ^ crc_reg[2];
assign next_crc[11] = crc_reg[3] ^ crc_reg[14] ^ data[1];
assign next_crc[12] = crc_reg[12] ^ crc_reg[4] ^ data[7] ^ crc_reg[15] ^ data[0] ^ crc_reg[8] ^ data[3];
assign next_crc[13] = crc_reg[13] ^ data[6] ^ crc_reg[5] ^ data[2] ^ crc_reg[9];
assign next_crc[14] = data[5] ^ crc_reg[14] ^ crc_reg[6] ^ data[1] ^ crc_reg[10];
assign next_crc[15] = data[4] ^ crc_reg[15] ^ data[0] ^ crc_reg[7] ^ crc_reg[11];


endmodule
//end of RTL code                       