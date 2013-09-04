module mux4_1d(out,in1,in2,in3,in4,cntrl1,cntrl2);
output out;
input in1,in2,in3,in4,cntrl1,cntrl2;
assign out=cntrl1 ? (cntrl2 ? in4:in3):(cntrl2 ? in2:in1);
endmodule
