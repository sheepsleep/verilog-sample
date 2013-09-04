module full_add1(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
wire s1,m1,m2,m3;

and (m1,a,b),
    (m2,b,cin),
    (m3,a,cin);
xor (s1,a,b),
    (sum,s1,cin);
or  (cout,m1,m2,m3);
endmodule
