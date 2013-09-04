module mux_case(out,in0,in1,in2,in3,sel);
output out;
input in0,in1,in2,in3;
input[1:0] sel;
reg out;

always @(in0 or in1 or in2 or in3 or sel)
begin
case(sel)
2'b00:  out=in0;
2'b01:  out=in1;
2'b10:  out=in2;
default: out=in3;
endcase
end
endmodule
