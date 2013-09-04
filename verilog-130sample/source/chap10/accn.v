`include "add8.v"
`include "reg8.v"

module accn(accout,cout,accin,cin,clk,clear);
output[7:0] accout;
output cout;
input[7:0] accin;
input cin,clk,clear;
wire[7:0] sum;

add8 accadd8(sum,cout,accout,accin,cin);
reg8 accreg8(accout,sum,clk,clear);

endmodule
