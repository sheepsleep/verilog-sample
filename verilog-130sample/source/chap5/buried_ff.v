module buried_ff(c,b,a);
output c;
input b,a;
reg c;

always @(a or b)
  begin
  if((b==1)&&(a==1))  c=a&b;
  end
endmodule
