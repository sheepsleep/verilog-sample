/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			wave_gen
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		wave_gen
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
module wave_gen ( 
              //input 
              sys_clk,
              sys_rst_n,
              fword,
              //output 
              da_clk,
              da_data
              );

//input ports

input                    sys_clk        ;      //system clock;
input                    sys_rst_n      ;    //system reset, low is active;
input  [WIDTH1-1:0]       fword         ;   //输入频率字
                                        
//output ports                          
output [SIZE-1:0]        da_data        ;    //DA 数据
output                   da_clk         ;    //DA 时钟
//reg define                            
reg    [WIDTH1-1:0]       fword_r       ;

reg    [WIDTH1-1:0]       freq_count    ;
reg    [WIDTH2-1:0]       rom_addr      ;

//wire define 


//parameter define 
parameter WIDTH1 = 32;
parameter WIDTH2 = 12;
parameter SIZE   = 10;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

assign da_clk = sys_clk        ;

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            fword_r <= 32'h0000;
        end
        else  
            fword_r <= fword;
end


always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            freq_count <= 32'h0000;
        end
        else  
            freq_count <= freq_count + fword_r;            //频率控制器
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
            rom_addr <= 32'h0000;
        end
        else  
            rom_addr <= freq_count[31:20] ;               //gen DA data by read ROM address
end

ROM DDS_ROM_U0 (
               .address (rom_addr) ,
               .clock   (sys_clk)  ,  
               .q       (da_data)   
               );


endmodule
//end of RTL code                       