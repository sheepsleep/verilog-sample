`timescale 10ns/1ns
module mult_tp;
reg[7:0] a,b;
wire [15:0] out;
integer i,j;

mult8 m1(out,a,b);

initial
begin
a=0;b=0;
for(i=1;i<255;i=i+1)
#10 a=i;
end
initial
begin
for(j=1;j<255;j=j+1)
#10 b=j;
end

initial
begin
$monitor($time,,,"%d * %d= %d",a,b,out);
#2560  $finish;
end
endmodule

module mult8(out, a, b);
parameter size=8;
input[size:1] a,b;
output[2*size:1] out;
assign out=a*b;
endmodule
