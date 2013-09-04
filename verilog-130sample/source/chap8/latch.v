primitive latch(Q,clk,reset,D);
input clk,reset,D;
output Q;
reg Q;
initial Q = 1'b1;
table
//clk reset D : state : Q
?   1   ?  : ? : 0 ;
0   0   0  : ? : 0 ;
0   0   1  : ? : 1 ;
1   0   ?  : ? : - ;
endtable
endprimitive
