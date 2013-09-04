primitive DFF(Q,D,clk);
output Q;
input D,clk;
reg Q;
table
//clk  D : state : Q
(01)  0   : ? :   0;
(01)  1   : ? :   1;
(0x)  1   : 1 :   1;
(0x)  0   : 0 :   0;
(?0)  ?   : ? :   -;
?   (??)  : ? :   -;
endtable
endprimitive
