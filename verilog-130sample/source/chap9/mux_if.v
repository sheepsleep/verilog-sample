module mux_if(out,in0,in1,in2,in3,sel);
output out;
input in0,in1,in2,in3;
input[1:0] sel;
reg out;

always @(in0 or in1 or in2 or in3 or sel)
begin
if(sel==2'b00)  	  out=in0;
else if(sel==2'b01) 	  out=in1;
else if(sel==2'b10) 	  out=in2;
else  			  out=in3;
end
endmodule
