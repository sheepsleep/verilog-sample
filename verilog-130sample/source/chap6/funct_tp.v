`define clk_cycle  50
`include "funct.v"
module funct_tp;
reg[3:0] n;
reg reset,clk;
wire[31:0] result;
initial
begin
n=0;  reset=1;  clk=0;
for(n=0;n<=15;n=n+1)
#100  n=n;
end
	
initial $monitor($time,,,"n=%d result=%d",n,result);

always  # `clk_cycle  clk=~clk;
	
funct funct_try(.clk(clk),.n(n),.result(result),.reset(reset));

endmodule