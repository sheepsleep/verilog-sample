module full_add5(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
reg cout,m1,m2,m3;        		//在always块中被赋值的变量应定义为reg型
wire s1;
xor x1(s1,a,b);       			//调用门元件
always @(a or b or cin)   		//always块语句
  	begin
m1 = a & b;
m2 = b & cin;
m3 = a & cin;
cout = (m1| m2) | m3;
end
assign sum = s1 ^ cin; 			//assign持续赋值语句
endmodule
