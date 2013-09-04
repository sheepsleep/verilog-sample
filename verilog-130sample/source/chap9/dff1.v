module DFF1(q,qn,d,clk,set,reset);
input d,clk,set,reset;
output q,qn;
reg q,qn;

always @(posedge clk or negedge set or negedge reset)
begin
if (!reset)
  begin
  q <= 0;
  qn <= 1;
  end
else if (!set)
  begin
  q <= 1;
  qn <= 0;
  end
else
  begin
  q <= d;
  qn <= ~d;
  end
end
endmodule
