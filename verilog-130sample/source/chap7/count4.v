module count4(clk,clr,out);
input clk,clr;
output[3:0] out;
reg[3:0] out;

always @(posedge clk or posedge clr)
begin
if (clr)  out<=0;
else 	  out<=out+1;
end
endmodule
