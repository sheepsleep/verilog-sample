module adder(cout,sum,a,b,cin);
parameter size=16;
output cout;
output[size-1:0] sum;
input cin;
input[size-1:0] a,b;
assign {cout,sum}=a+b+cin;
endmodule