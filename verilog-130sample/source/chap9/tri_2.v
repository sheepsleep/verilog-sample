module tri_2(out,in,en);
output out;
input in,en;
assign out = en ? in : 'bz;
endmodule
