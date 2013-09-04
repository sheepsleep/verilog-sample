module block(c,b,a,clk);
output c,b;
input clk,a;
reg c,b;
always @(posedge clk)
  begin
  b=a;
  c=b;
  end
endmodule
