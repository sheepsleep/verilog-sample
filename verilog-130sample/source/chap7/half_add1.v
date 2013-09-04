module half_add1(a,b,sum,cout);
input a,b;
output sum,cout;
and (cout,a,b);
xor (sum,a,b);
endmodule
