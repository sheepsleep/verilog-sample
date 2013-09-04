`timescale 1ns/1ns
module add8_tp;
reg[7:0] A,B;
reg cin;
wire[7:0] SUM;
wire cout;
parameter DELY = 100;

add8  AD1(SUM,cout,A,B,cin);

initial begin
      	A= 8'd0; 	B= 8'd0;	cin=1'b0;
#DELY 	A= 8'd100; 	B= 8'd200;	cin=1'b1;
#DELY 	A= 8'd200; 	B= 8'd88;
#DELY 	A= 8'd210; 	B= 8'd18;	cin=1'b0;
#DELY 	A= 8'd12; 	B= 8'd12;
#DELY 	A= 8'd100; 	B= 8'd154;
#DELY 	A= 8'd255; 	B= 8'd255;	cin=1'b1;
#DELY 	$finish;
end

initial $monitor($time,,,"%d + %d + %b = {%b, %d}",A,B,cin,cout,SUM);
endmodule

module add8(SUM,cout,A,B,cin);
output[7:0] SUM;
output cout;
input[7:0] A,B;
input cin;
assign {cout,SUM}=A+B+cin;
endmodule
