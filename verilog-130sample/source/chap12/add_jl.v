module add_jl(sum,cout,a,b,cin);
output[7:0] sum;
output cout;
input[7:0] a,b;
input cin;

full_add1 f0(a[0],b[0],cin,sum[0],cin1);
full_add1 f1(a[1],b[1],cin1,sum[1],cin2);
full_add1 f2(a[2],b[2],cin2,sum[2],cin3);
full_add1 f3(a[3],b[3],cin3,sum[3],cin4);
full_add1 f4(a[4],b[4],cin4,sum[4],cin5);
full_add1 f5(a[5],b[5],cin5,sum[5],cin6);
full_add1 f6(a[6],b[6],cin6,sum[6],cin7);
full_add1 f7(a[7],b[7],cin7,sum[7],cout);
endmodule

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
