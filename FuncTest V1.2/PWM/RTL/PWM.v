/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			PWM
** Last modified Date:	2011-12-23
** Last Version:		1.0
** Descriptions:		PWM Project
**------------------------------------------------------------------------------------------------------
** Created by:		    dongdong
** Created date:		2011-12-23
** Version:				1.0
** Descriptions:		The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:        PWM function moto run & stop & change speed & reverse run 

** 使用说明：

** KEY1 KEY2 KEY3 KEY4 : 1 0 0 1 正向高速运转
** KEY1 KEY2 KEY3 KEY4 : 1 0 1 0 正向低速运转

** KEY1 KEY2 KEY3 KEY4 : 1 1 0 1 反向高速运转
** KEY1 KEY2 KEY3 KEY4 : 1 1 1 0 反向低速运转

** PIN_25 -to key[0]
** PIN_24 -to key[1]
** PIN_9  -to key[2]
** PIN_8  -to key[3]

**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module PWM ( 
                  //input 
input			  sys_clk   ,
input    [3:0]    key       ,

                  //output 
output wire       led       ,
output reg        moto_a    ,  
output reg        moto_b     );

// parameter define 

// reg define 
reg [1:0]               counter          ;

reg                      pwm_out          ;


// wire define 
wire                     moto_en          ;
wire                     moto_direction   ;
wire                     moto_speed0      ;
wire                     moto_speed1      ;

wire                     sys_rst_n       ; 

/*******************************************************************
**                Main Program    
*******************************************************************/

assign sys_rst_n = 1'b1 ;

// assign moto ctrl signal 
assign moto_en        = ~key[0] ; 
assign moto_direction = ~key[1] ;
assign moto_speed0    = ~key[2] ;
assign moto_speed1    = ~key[3] ;

// PWM cnt 
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
            counter <= 2'h0;
        else if ( moto_en == 1'b1 ) begin
            if ( moto_speed0 ==1'b1 && counter == 2'h1 )
                counter  <= 2'h0;
            else if ( moto_speed1 ==1'b1 && counter == 2'h2 )
                counter  <= 2'h0;   
            else if ( moto_speed0 == 1'b1 || moto_speed1 == 1'b1 )
                counter  <= counter + 2'b1;
            else 
                counter <= 2'h0;
        end
        else 
            counter <= 2'h0;
end

// PWM state process
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
            pwm_out <= 1'b0;
        else if ( counter >= 2'h1)   
            pwm_out  <= 1'b1;
        else 
            pwm_out  <= 1'b0;
end

// Moto direction process
always @( * ) begin 
    if ( moto_direction == 1'b0 ) begin 
        moto_a = pwm_out        ;
        moto_b = 1'b0           ;
    end
    else begin
        moto_a = 1'b0           ;
        moto_b = pwm_out        ;
    end
end

// led debug
assign led = pwm_out;

endmodule
//end of RTL code                       
