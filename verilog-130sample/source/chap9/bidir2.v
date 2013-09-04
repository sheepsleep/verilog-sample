module bidir2(bidir,en,clk);
inout[7:0] bidir;
input en,clk;
reg[7:0] temp;
assign bidir= en ? temp : 8'bz;
always @(posedge clk)
begin
if(en) 	temp=bidir;
else 	temp=temp+1;
end
endmodule
