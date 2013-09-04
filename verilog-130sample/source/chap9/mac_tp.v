'timescale 1ns/1ns
`include "mac.v"
module mac_tp;
reg[7:0] opa,opb;
reg clr,clk;
wire[15:0] out;
parameter DELY = 100;

MAC m1(out,opa,opb,clk,clr);

always #(DELY) clk = ~clk; 

initial begin
      clr=1;clk=0;opa=8'd0; opb=8'd0;
#DELY clr=0;opa=8'd1; opb=8'd10;
#DELY opa=8'd2; opb=8'd10;
#DELY opa=8'd3; opb=8'd10;
#DELY opa=8'd4; opb=8'd10;
#DELY opa=8'd5; opb=8'd10;
#DELY opa=8'd6; opb=8'd10;
#DELY opa=8'd7; opb=8'd10;
#DELY opa=8'd8; opb=8'd10;
#DELY opa=8'd9; opb=8'd10;
#DELY opa=8'd10; opb=8'd10;
#DELY $finish;
end

initial $monitor($time,,,"clr=%b opa=%d opb=%d out=%d",clr,opa,opb,out);
endmodule
