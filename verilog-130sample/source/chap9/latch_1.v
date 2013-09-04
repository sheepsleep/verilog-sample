module latch_1(q,d,clk);
output q;
input d,clk;
assign q = clk ? d : q;
endmodule
