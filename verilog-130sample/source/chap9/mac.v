module MAC(out,opa,opb,clk,clr);
output[15:0] out;
input[7:0] opa,opb;
input clk,clr;
wire[15:0] sum;
reg[15:0] out;

function[15:0] mult;
input[7:0] opa,opb;
reg[15:0] result;
integer i;

begin
result = opa[0]? opb : 0;
for(i= 1; i <= 7; i = i+1)
begin
if(opa[i]==1)  result=result+(opb<<(i-1));
end
mult=result;
end
endfunction

assign sum=mult(opa,opb)+out;

always @(posedge clk or posedge clr)
begin
if(clr) out<=0;
else  	out<=sum;
end
  
endmodule
