/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           ps2key
** Last modified Date:  2009-11-8
** Last Version:        1.0
** Descriptions:        ps2key
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-11-8
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
module ps2key ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              ps2_key_clk    ,
              ps2_key_data   ,
              
              clk_256        ,
              //output 
              data_out       ,
              led
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;

input                    ps2_key_clk         ;    //ps2 beyboard clock;
input                    ps2_key_data        ;    //ps2 beyboard data ;


//output ports
output [WIDTH-1:0]       data_out            ;   // output KEY value,in hex format
output [WIDTH-1:0]       clk_256             ;   // for signaltap II debug use
output [WIDTH-1:0]       led                 ;   // output led,in hex format
//reg define 
reg    [WIDTH-1:0]       data_out            ;   // output KEY value,in hex format


reg    [10:0]            buff                ;   // for regsiger data 


reg                      clk_2               ;   // for signaltap II debug use    
reg                      clk_4               ;   // for signaltap II debug use 
reg                      clk_8               ;   // for signaltap II debug use 
reg                      clk_16              ;   // for signaltap II debug use 
reg                      clk_32              ;   // for signaltap II debug use 
reg                      clk_64              ;   // for signaltap II debug use 
reg                      clk_128             ;   // for signaltap II debug use 
reg                      clk_256             ;   // for signaltap II debug use 

//wire define 


//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 8;

parameter WIDTH2 = 18;

parameter Para  = 50;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

//generate signaltap II clock begin
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_2 <= 'b0;
        end
        else  
            clk_2  <= ~clk_2;
end

always @(posedge clk_2 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_4 <= 'b0;
        end
        else  
            clk_4  <= ~clk_4;
end

always @(posedge clk_4 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_8 <= 'b0;
        end
        else  
            clk_8  <= ~clk_8;
end

always @(posedge clk_8 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_16 <= 'b0;
        end
        else  
            clk_16  <= ~clk_16;
end

always @(posedge clk_16 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_32 <= 'b0;
        end
        else  
            clk_32  <= ~clk_32;
end

always @(posedge clk_32 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_64 <= 'b0;
        end
        else  
            clk_64  <= ~clk_64;
end


always @(posedge clk_64 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_128 <= 'b0;
        end
        else  
            clk_128  <= ~clk_128;
end

always @(posedge clk_128 or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            clk_256 <= 'b0;
        end
        else  
            clk_256  <= ~clk_256;
end
//generate signaltap II clock end

always @(negedge ps2_key_clk ) begin 
    buff[0]  <= ps2_key_data   ;
    buff[1]  <= buff[0]        ;
    buff[2]  <= buff[1]        ;
    buff[3]  <= buff[2]        ;
    buff[4]  <= buff[3]        ;
    buff[5]  <= buff[4]        ;
    buff[6]  <= buff[5]        ;
    buff[7]  <= buff[6]        ;
    buff[8]  <= buff[7]        ;
    buff[9]  <= buff[8]        ;
    buff[10] <= buff[9]        ;
end
  
always @(*) begin
    data_out[7]  <= buff[2];  
    data_out[6]  <= buff[3];  
    data_out[5]  <= buff[4];  
    data_out[4]  <= buff[5];  
    data_out[3]  <= buff[6];  
    data_out[2]  <= buff[7];  
    data_out[1]  <= buff[8];  
    data_out[0]  <= buff[9];
end 

//assign led = ~ data_out ;             //led is low acitve

assign led = data_out ;             //led is low acitve

endmodule
//end of RTL code                

/**************键盘上各个键的码表,16 进制格式***********************/

//   0x1C,   <=======>    'a',
//   0x32,   <=======>    'b',
//   0x21,   <=======>    'c',
//   0x23,   <=======>    'd',
//   0x24,   <=======>    'e',
//   0x2B,   <=======>    'f',
//   0x34,   <=======>    'g',
//   0x33,   <=======>    'h',
//   0x43,   <=======>    'i',
//   0x3B,   <=======>    'j',
//   0x42,   <=======>    'k',
//   0x4B,   <=======>    'l',
//   0x3A,   <=======>    'm',
//   0x31,   <=======>    'n',
//   0x44,   <=======>    'o',
//   0x4D,   <=======>    'p',
//   0x15,   <=======>    'q',
//   0x2D,   <=======>    'r',
//   0x1B,   <=======>    's',
//   0x2C,   <=======>    't',
//   0x3C,   <=======>    'u',
//   0x2A,   <=======>    'v',
//   0x1D,   <=======>    'w',
//   0x22,   <=======>    'x',
//   0x35,   <=======>    'y',
//   0x1A,   <=======>    'z',
//   0x45,   <=======>    '0',
//   0x16,   <=======>    '1',
//   0x1E,   <=======>    '2',
//   0x26,   <=======>    '3',
//   0x25,   <=======>    '4',
//   0x2E,   <=======>    '5',
//   0x36,   <=======>    '6',
//   0x3D,   <=======>    '7',
//   0x3E,   <=======>    '8',
//   0x46,   <=======>    '9',
//   0x0E,   <=======>    '`',
//   0x4E,   <=======>    '-',
//   0x55,   <=======>    '=',
//   0x5D,   <=======>    '\\',
//   0x29,   <=======>    ' ',
//   0x54,   <=======>    '[',
//   0x5B,   <=======>    ']',
//   0x4C,   <=======>    ';',
//   0x52,   <=======>    '\'',
//   0x41,   <=======>    ',',
//   0x49,   <=======>    '.',
//   0x4A,   <=======>    '/',
//   0x71,   <=======>    '.',
//   0x70,   <=======>    '0',
//   0x69,   <=======>    '1',
//   0x72,   <=======>    '2',
//   0x7A,   <=======>    '3',
//   0x6B,   <=======>    '4',
//   0x73,   <=======>    '5',
//   0x74,   <=======>    '6',
//   0x6C,   <=======>    '7',
//   0x75,   <=======>    '8',
//   0x7D,   <=======>    '9',
//   0x0d,   <=======>    ' ',

/**************键盘上各个键的码表,结束***********************/
      