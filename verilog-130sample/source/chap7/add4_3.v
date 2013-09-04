module add4_3(cout,sum,a,b,cin);
output[3:0] sum;
output cout;
input[3:0] a,b;
input cin;
reg[3:0] sum;
reg cout;

always @(a or b or cin)
begin
{cout,sum}=a+b+cin;
end
endmodule
