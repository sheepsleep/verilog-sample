module add8(sum,cout,b,a,cin);
output[7:0] sum;
output cout;
input[7:0] a,b;
input cin;
assign {cout,sum}=a+b+cin;
endmodule
