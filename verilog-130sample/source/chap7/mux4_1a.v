module mux4_1a(out,in1,in2,in3,in4,cntrl1,cntrl2);
output out;
input in1,in2,in3,in4,cntrl1,cntrl2;
wire notcntrl1,notcntrl2,w,x,y,z;
not 	(notcntrl1,cntrl2),
(notcntrl2,cntrl2);
and 	(w,in1,notcntrl1,notcntrl2),
 	(x,in2,notcntrl1,cntrl2),
 	(y,in3,cntrl1,notcntrl2),
(z,in4,cntrl1,cntrl2);
or 	(out,w,x,y,z);	
endmodule
