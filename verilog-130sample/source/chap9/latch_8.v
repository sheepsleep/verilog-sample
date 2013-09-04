module latch_8(qout,data,clk);
output[7:0] qout;
input[7:0] data;
input clk;
reg[7:0] qout;

always @(clk or data)
begin
if (clk) qout<=data;
end
endmodule
