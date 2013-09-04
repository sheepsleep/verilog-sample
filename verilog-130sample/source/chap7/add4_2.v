module add4_2(cout,sum,a,b,cin);
output[3:0] sum;
output cout;
input[3:0] a,b;
input cin;
assign {cout,sum}=a+b+cin;
endmodule
