module count10(out,cout,en,clr,clk);
output[3:0] out;
output cout;
input en,clr,clk;
reg[3:0] out;

always @(posedge clk or posedge clr) 
  begin 
	if (clr)  out = 0;
	else   if(en)
	begin
	if(out==9) 	out=0;
	else  		out = out+1;
	end
  end

assign  cout =((out==9)&en)?1:0;
endmodule
