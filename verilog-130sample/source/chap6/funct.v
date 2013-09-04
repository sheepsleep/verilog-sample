module funct(clk,n,result,reset);
output[31:0] result;
input[3:0] n;
input reset,clk;
reg[31:0] result;

always @(posedge clk)
begin
if(!reset)  result<=0;
else  begin
result <= 2 * factorial(n);
end
end

function[31:0] factorial;
input[3:0] opa;
reg[3:0] i;
begin
factorial = opa ? 1 : 0;
for(i= 2; i <= opa; i=i+1)
factorial = i* factorial;
end
endfunction
endmodule
