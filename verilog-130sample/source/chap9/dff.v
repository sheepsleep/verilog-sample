module DFF(Q,D,CLK);
output Q;
input D,CLK;
reg Q;
always @(posedge CLK)
begin
Q <= D;
end
endmodule
