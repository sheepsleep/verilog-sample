module AOI(A,B,C,D,F);
input A,B,C,D;
output F;
wire A,B,C,D,F;
assign  F= ~((A&B)|(C&D));
endmodule
