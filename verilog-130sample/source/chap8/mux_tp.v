`timescale 1ns/1ns
module mux_tp;
reg a,b,sel;
wire out;

MUX2_1 m1(out,a,b,sel);

initial
begin
a=1'b0; b=1'b0; sel=1'b0;
#5  	sel=1'b1;
#5  	a=1'b1; 	sel=1'b0;
#5  	sel=1'b1;
#5  	a=1'b0;	b=1'b1; sel=1'b0;
#5  	sel=1'b1;
#5  	a=1'b1;	b=1'b1;	sel=1'b0;
#5  	sel=1'b1;
end
initial $monitor($time,,,"a=%b b=%b sel=%b out=%b",a,b,sel,out);
endmodule

module MUX2_1(out,a,b,sel);
input a,b,sel;
output out;
not #(0.4,0.3) (sel_,sel);
and #(0.7,0.6) (a1,a,sel_);
and #(0.7,0.6) (a2,b,sel);
or #(0.7,0.6) (out,a1,a2);
endmodule
