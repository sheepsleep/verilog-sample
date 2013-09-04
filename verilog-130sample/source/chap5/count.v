module count(out,data,load,reset,clk);
output[7:0] out;
input[7:0] data;
input load,clk,reset;
reg[7:0] out;

always @(posedge clk)
begin
if (!reset)  	out = 8'h00;
else if (load)  out = data;
else	 	out = out + 1;
end
endmodule
