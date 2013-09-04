module mux4_1c(out,in1,in2,in3,in4,cntrl1,cntrl2);
output out;
input in1,in2,in3,in4,cntrl1,cntrl2;
assign out=(in1 & ~cntrl1 & ~cntrl2)|(in2 & ~cntrl1 & cntrl2)|
       (in3 & cntrl1 & ~cntrl2)|(in4 & cntrl1 & cntrl2);
endmodule
