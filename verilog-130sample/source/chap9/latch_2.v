module latch_2(q,d,clk,set,reset);
output q;
input d,clk,set,reset;
assign q = reset ? 0 : (set ? 1 : (clk ? d : q));
endmodule
