module serial2(q,a,clk);
output q,a;
input clk;
reg q,a;

always @(posedge clk)
begin
a=~q;
q=~q;
end
endmodule
