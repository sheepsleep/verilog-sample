`include "alutask.v"
module alu_tp;
reg[3:0] a,b;
reg[1:0] code;
wire[4:0] c;
parameter DELY = 100;
	
alutask ADD(code,a,b,c);
	
initial begin
       	code=4'd0; a= 4'b0000; b= 4'b1111;
#DELY 	code=4'd0; a= 4'b0111; b= 4'b1101;
#DELY 	code=4'd1; a= 4'b0001; b= 4'b0011;
#DELY 	code=4'd2; a= 4'b1001; b= 4'b0011;
#DELY 	code=4'd3; a= 4'b0011; b= 4'b0001;
#DELY 	code=4'd3; a= 4'b0111; b= 4'b1001;
#DELY 	$finish;
end
initial $monitor($time,,,"code=%b a=%b b=%b c=%b", code,a,b,c);
endmodule
