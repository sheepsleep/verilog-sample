module full_add4(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
reg sum,cout;
reg m1,m2,m3;

always @(a or b or cin)
begin
sum = (a ^ b) ^ cin;
m1 = a & b;
m2 = b & cin;
m3 = a & cin;
cout = (m1|m2)|m3;
end
endmodule
