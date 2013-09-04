module resource1(sum,a,b,c,d,sel);
parameter size=4;
output[size:0] sum;
input sel;
input[size-1:0] a,b,c,d;
reg[size:0] sum;

always @(a or b or c or d or sel)
begin
if(sel) sum=a+b;
else  	sum=c+d;
end
endmodule
