module compile(out,A,B);
output out;
input A,B;
`ifdef  add
assign out=A+B;
`else
assign out=A-B;
`endif
endmodule
