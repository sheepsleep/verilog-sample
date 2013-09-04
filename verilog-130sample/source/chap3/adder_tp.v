`timescale 1ns/1ns
`include "adder4.v"
module adder_tp;
reg[3:0] a,b;
reg cin;
wire[3:0] sum;
wire cout;
integer i,j;

adder4 adder(sum,cout,a,b,cin);
always #5 cin=~cin;

initial
begin
a=0;b=0;cin=0;
for(i=1;i<16;i=i+1)
#10   a=i;
end

initial
begin
for(j=1;j<16;j=j+1)
#10   b=j;
end

initial 
begin
$monitor($time,,,"%d + %d + %b={%b,%d}",a,b,cin,cout,sum);
#160  $finish;
end
endmodule
