module paral2(q,a,clk);
output q,a;
input clk;
reg q,a;

always @(posedge clk)
begin
a=~q;
end

always @(posedge clk)
begin
q=~q;
end
endmodule
