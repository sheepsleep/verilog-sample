module gate1(F,A,B,C,D);
input A,B,C,D;
output F;
nand(F1,A,B);
and(F2,B,C,D);
or(F,F1,F2);
endmodule
