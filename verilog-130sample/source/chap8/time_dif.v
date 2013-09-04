`timescale 10ns/1ns
module time_dif;
reg ts;
parameter delay=2.6;
initial
  	begin
    	#delay  ts=1;
    	#delay  ts=0;
    	#delay  ts=1;
	#delay  ts=0;
  	end
initial  $monitor($time,,,"ts=%b",ts);
endmodule
