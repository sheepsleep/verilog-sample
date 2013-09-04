module tri_1(in,en,out);
input in,en;
output out;
tri out;
bufif1 b1(out,in,en);
endmodule
