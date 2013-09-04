`timescale 10ns/1ns
module count8_tp;
reg clk,reset;
wire[7:0] qout;
parameter DELY=100;

counter  C1(qout,reset,clk);

always #(DELY/2) clk = ~clk;

initial
begin
      	clk =0; reset=0;
#DELY  	reset=1;
#DELY  	reset=0;
#(DELY*300) $finish;
end

initial $monitor($time,,,"clk=%d reset=%d qout=%d",clk,reset,qout);
endmodule

module counter(qout,reset,clk);
output[7:0] qout;
input clk,reset;
reg[7:0] qout;

always @(posedge clk)
begin
if (reset) qout<=0;
else	   qout<=qout+1;
end
endmodule
