module johnson(clk,clr,out);
input clk,clr;
output[3:0] out;
reg[3:0] out;

always @(posedge clk or posedge clr)
begin
if (clr)  out<= 4'h0;
else
  begin	
  out<= out<< 1;
  out[0]<= ~out[3];
  end
end
endmodule
