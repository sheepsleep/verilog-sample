module half_add4(a,b,sum,cout);
input a,b;
output sum,cout;
reg sum,cout;

always @(a or b)
begin
sum= a^b;
cout=a&b;
end
endmodule
