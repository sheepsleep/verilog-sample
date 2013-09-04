module serial_pal(clk,reset,en,in,out);
input clk,reset,en,in;
output[3:0] out;
reg[3:0] out;

always @(posedge clk)
begin
if(reset) 	out<=4'h0;
else if(en) 	out<={out,in};
end
endmodule
