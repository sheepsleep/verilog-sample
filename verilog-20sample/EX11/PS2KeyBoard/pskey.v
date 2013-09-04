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

module  pskey(reset,ps2clk,ps2data,over,data);

input   reset,ps2clk,ps2data;
output reg  over;
output reg [7:0] data;

reg [10:0] temp;
reg [3:0]  cnt4;

always@(posedge reset or negedge ps2clk)
    if (reset)
       begin
          temp<=11'b0;
	      cnt4<=4'b0;
	    end
	else
	    begin
	        temp<={ps2data,temp[10:1]};
		    cnt4<=cnt4+1;
			if(cnt4==10) 
			  begin
				  data<=temp[9:2];
				  cnt4<=4'b0;
				  over<=1'b1;
			   end
			 else
				  over<=1'b0;
		 end
endmodule
