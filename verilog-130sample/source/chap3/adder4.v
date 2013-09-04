module adder4(cout,sum,ina,inb,cin);
output[3:0] sum;
output cout;
input[3:0] ina,inb;
input cin;
assign {cout,sum}=ina+inb+cin;
endmodule
