module MUX21_1(out,a,b,sel);
input a,b,sel;
output out;
assign out=(sel==0)?a:b; 
endmodule
