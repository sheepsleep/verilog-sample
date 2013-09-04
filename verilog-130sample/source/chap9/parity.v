module parity(even_bit,odd_bit,input_bus);
output even_bit,odd_bit;
input[7:0] input_bus;
assign odd_bit = ^input_bus;
assign even_bit = ~odd_bit;
endmodule
