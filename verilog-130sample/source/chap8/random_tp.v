`timescale 10ns/1ns
module random_tp;
integer data;
integer i;
parameter delay=10;
	
initial $monitor($time,,,"data=%b",data);
initial
begin
for(i=0; i<=100; i=i+1)
#delay  data=$random;
end
endmodule
