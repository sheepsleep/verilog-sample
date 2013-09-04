module shifter(din,clk,clr,dout);
input din,clk,clr;
output[7:0] dout;
reg[7:0] dout;

always @(posedge clk)
begin
if (clr)  dout<= 8'b0;
else
  begin
  dout <= dout << 1;
  dout[0] <= din;
  end
end
endmodule
