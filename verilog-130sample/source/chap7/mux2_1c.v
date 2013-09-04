module MUX2_1c(out,a,b,sel);
output out;
input a,b,sel;
assign out = sel ? b : a;
endmodule
