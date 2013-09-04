module adder8(cout,sum,ina,inb,cin,clk);
output[7:0] sum;
output cout;
input[7:0] ina,inb;
input cin,clk;
reg[7:0] tempa,tempb,sum;
reg cout;
reg tempc;

always @(posedge clk)
begin
tempa=ina;
tempb=inb;
tempc=cin;
end

always @(posedge clk)
begin
{cout,sum}=tempa+tempb+tempc;
end
endmodule
