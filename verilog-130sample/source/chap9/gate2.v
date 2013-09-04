module gate2(F,A,B,C,D);
input A,B,C,D;
output F;
assign F=(A&B)|(B&C&D);
endmodule
