module mult_repeat(outcome,a,b);
parameter size=8;
input[size:1] a,b;
output[2*size:1] outcome;
reg[2*size:1] temp_a,outcome;
reg[size:1] temp_b;

always @(a or b)
begin
outcome=0;
temp_a=a;
temp_b=b;
repeat(size)
  begin
  if(temp_b[1])
  outcome=outcome+temp_a;
  temp_a=temp_a<<1;
  temp_b=temp_b>>1;
  end
end
endmodule
