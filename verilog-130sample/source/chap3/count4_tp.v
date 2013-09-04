`timescale 1ns/1ns
`include "count4.v"
module coun4_tp;
reg clk,reset;
wire[3:0] out;
parameter DELY=100;

count4 mycount(out,reset,clk);

always #(DELY/2) clk = ~clk;
initial
begin
clk =0; reset=0;
#DELY  	reset=1;
#DELY  	reset=0;
#(DELY*20) $finish;
end

initial $monitor($time,,,"clk=%d reset=%d out=%d", clk, reset,out);
endmodule
