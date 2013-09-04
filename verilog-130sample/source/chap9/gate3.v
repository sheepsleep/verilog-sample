module gate3(F,A,B,C,D);
input A,B,C,D;
output F;
reg F;

always @(A or B or C or D)
begin
F=(A&B)|(B&C&D);
end
endmodule
