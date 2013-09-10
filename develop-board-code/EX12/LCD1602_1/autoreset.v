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

module	autoreset(
				clk,
				rst_n,
				clkout,
				arst_n		
				);

input		clk; //50MHz时钟输入
input		rst_n; //复位信号输入，低电平有效
output	    arst_n;//复位信号输出，低电平有效
output      clkout;//时钟信号输出，50MHz

//----------------------------------------
// 系统时钟50M 分频
parameter	DIV	= 25_000_00;
reg	 [24:0] count;
reg  clk_div;
always @(posedge clk)
begin
   if( count == DIV)//分频比较
	 begin
	 count <= 0;
	 clk_div = ~clk_div;//信号取反
	 end
   else
	 count <= count + 1'b1;//加1计数
end
//----------------------------------------

//----------------------------------------
reg	 [7:0] cnt;
reg  rst_tmp;
always @(posedge clk_div)
begin
   if (cnt<1)
     begin
       rst_tmp=0;
       cnt =cnt+1;
     end
   else
       rst_tmp=1;
end
//----------------------------------------
assign arst_n=rst_tmp&rst_n;
assign clkout=rst_tmp&clk;
endmodule