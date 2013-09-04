module fre_ctrl(clk,rst,count_en,count_clr,load);
output count_en,count_clr,load;
input clk,rst;
reg count_en,load;

always @(posedge clk)
  begin
	if(rst)
	 	begin  count_en=0;  load=1;  end
	else  	begin
	count_en=~count_en;
	load=~count_en;
	end
  end

assign  count_clr=~clk&load;
endmodule
