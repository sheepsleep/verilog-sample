////////////////////////////////////////////////////////////////////////////////
//  Company: 成都锐创智能科技 Ruichuang Smart Technology                      //
//           http://ruicstech.taobao.com                                      // 
//  Engineer:      Youzhiyu                                                   //
//  QQ      :      4016682                                                    //
//  Target Device: MAXII240T100C5N                                            //
//  Tool versions: Quartus II 7.2                                             //
//  Create Date:   2011-09-06 10:09                                           //
//  Description:                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved                //
//----------------------------------------------------------------------------//
////////////////////////////////////////////////////////////////////////////////

module		LED_FLASH(
				clk,   
				rst_n, 
				led	   
				);

input		    clk;//50MHz时钟输入
input		    rst_n;//复位信号输入
output [7:0]    led;//LED输出

reg clk_1Hz;

// 系统时钟50M 分频系数 25M 得到  1hz信号
parameter	DIV	= 25_000_000;

// 2 ^ 25	 = 32*1024*1024		
reg	 [24:0] count;
reg  [7:0]  STATUS;

//时钟分频
always @(posedge clk)
begin
		if( count == DIV)
		begin
			count <= 0;
			clk_1Hz = ~clk_1Hz;
		end
		else
			count <= count + 1'b1;	
end


always @(posedge clk_1Hz or negedge rst_n)
    if ( !rst_n )
         STATUS<="11111110";
    else 
		 STATUS<={STATUS[6:0],STATUS[7]};//循环移位操作

assign led=STATUS;

endmodule