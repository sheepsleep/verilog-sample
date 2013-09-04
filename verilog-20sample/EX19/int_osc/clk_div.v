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

module		clk_div(
				clk_in,
				clk_out		
				);

input		clk_in;
output	    clk_out;

reg		    clk_out;

// 系统时钟5M 分频 1hz信号
parameter	DIV	= 2500_000;
	
reg	 [24:0] count;

always @(posedge clk_in)
begin
		if( count == DIV)
		begin
			count <= 0;
			clk_out = ~clk_out;
		end
		else
			count <= count + 1'b1;	
end
endmodule