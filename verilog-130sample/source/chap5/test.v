`timescale 1ns/1ns
module test;
reg A,B,C;
initial
  begin
       	A = 0; 	B = 1; 	C = 0;
  #50 	A = 1; 	B = 0;
  #50 	A = 0; 	C = 1;
  #50 	B = 1;
  #50 	B = 0; 	C = 0;
  #50 	$finish ;
  end
endmodule
