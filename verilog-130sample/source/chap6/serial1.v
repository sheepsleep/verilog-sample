module serial1(q,a,clk);
output q,a;
input clk;
reg q,a;

always @(posedge clk)
begin
q=~q;
a=~q;
end
endmodule
