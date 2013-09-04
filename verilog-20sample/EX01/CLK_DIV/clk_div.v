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

module	clk_div(
				clk_in,
				clk_out		
				);

input		clk_in; //50MHz时钟输入
output	    clk_out;//1Hz时钟输出
reg		    clk_out;

// 系统时钟50M 分频系数 25M 得到  1hz信号
parameter	DIV	= 25_000_000;

// 2 ^ 25	 = 32*1024*1024		
reg	 [24:0] count;

always @(posedge clk_in)
begin
		if( count == DIV)//分频比较
		   begin
			  count <= 0;
			  clk_out = ~clk_out;//信号取反
		   end
		else
			count <= count + 1'b1;//加1计数
end
endmodule