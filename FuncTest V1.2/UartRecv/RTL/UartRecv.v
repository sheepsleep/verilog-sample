/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           UartRecv
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        UartRecv
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
module UartRecv ( 
              //input 
              sys_clk        ,
              sys_rst_n      ,
              uart_rxd       ,

              //output 
              LED
              );

//input ports

input                    sys_clk             ;    //system clock;
input                    sys_rst_n           ;    //system reset, low is active;
input                    uart_rxd            ;    //uart rxd input ;    

//output ports
output reg [WIDTH-1:0]   LED                ;

//reg define 
reg    [WIDTH-1:0]       buff                ;         
reg    [WIDTH-1:0]       data_out            ; 

reg                      uart_rxd_dly1       ;    //uart rxd input ;   
reg                      uart_rxd_dly2       ;    //uart rxd input ;   
reg                      uart_rxd_dly3       ;    //uart rxd input ; 
reg                      uart_rxd_dly4       ;    //uart rxd input ; 
     
reg                      rxd_negdge_sig_dly1 ;

     
reg  [SIZE-1:0]          counter             ;     
     
//wire define 
wire                     rxd_negdge_sig      ;

//parameter define 
parameter WIDTH = 8;
parameter SIZE  = 16;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0) begin 
           uart_rxd_dly1 <= 1'b0;
           uart_rxd_dly2 <= 1'b0;
           uart_rxd_dly3 <= 1'b0;           
           uart_rxd_dly4 <= 1'b0;           
        end
        else begin
           uart_rxd_dly1  <= uart_rxd     ;
           uart_rxd_dly2  <= uart_rxd_dly1; 
           uart_rxd_dly3  <= uart_rxd_dly2;           
           uart_rxd_dly4  <= uart_rxd_dly3;            
        end   
end

assign rxd_negdge_sig = (~uart_rxd_dly3) & uart_rxd_dly4;  

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
           rxd_negdge_sig_dly1 <= 1'b0;        
        else  
           rxd_negdge_sig_dly1  <= rxd_negdge_sig;                    
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if ( sys_rst_n == 1'b0 )  
            counter <= 16'b0;
        else if ( rxd_negdge_sig_dly1 == 1'b1 && counter > 57200 ) 
            counter <= 16'b0;
        else if ( counter <= 57200 )  
            counter  <= counter + 16'b1;   
        else ;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if ( sys_rst_n == 1'b0 )  
        buff <= 8'b0;    
    else begin 
        case ( counter )
             7800     :   buff[0]  <=  uart_rxd_dly4     ;
             13000    :   buff[1]  <=  uart_rxd_dly4     ;
             18200    :   buff[2]  <=  uart_rxd_dly4     ;
             23400    :   buff[3]  <=  uart_rxd_dly4     ;
             28600    :   buff[4]  <=  uart_rxd_dly4     ;
             33800    :   buff[5]  <=  uart_rxd_dly4     ;
             39000    :   buff[6]  <=  uart_rxd_dly4     ;
             44200    :   buff[7]  <=  uart_rxd_dly4     ;
             default  :   buff     <=  buff              ;    
        endcase
    end
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
           LED <= 8'b0;        
        else  
           LED <= buff;        
end

endmodule
//end of RTL code                       