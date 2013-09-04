module mult(outcome,a,b);
parameter size=8;
input[size:1] a,b;
output[2*size:1] outcome;
assign outcome=a*b;
endmodule
