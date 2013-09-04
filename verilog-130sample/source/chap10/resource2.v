module resource2(sum,a,b,c,d,sel);
parameter size=4;
output[size-1:0] sum;
input sel;
input[size-1:0] a,b,c,d;
reg[size-1:0] atemp,btemp;
reg[size:0] sum;

always @(a or b or c or d or sel)
begin
if(sel) begin  atemp=a;  btemp=b;  end
else  	begin  atemp=c;  btemp=d;  end
sum=atemp+btemp;
end
endmodule
