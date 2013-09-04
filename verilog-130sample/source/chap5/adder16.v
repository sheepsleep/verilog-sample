`include "adder.v"

module adder16(cout,sum,a,b,cin);
output cout;
parameter my_size=16;
output[my_size-1:0] sum;
input[my_size-1:0] a,b;
input cin;

adder my_adder(cout,sum,a,b,cin);
endmodule
