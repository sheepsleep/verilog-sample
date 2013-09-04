primitive DFF_UDP(Q,D,clk,clr,set);
output Q;
input D,clk,clr,set;
reg Q;
table
// clk 	D	clr 	set 	: state : Q
(01)	1	0	0	: ? :	0;
(01)	1	0	x	: ? :	0;
?	?	0	x	: 0 :	0;
(01)	0	0	0	: ? :	1;
(01)	0	x	0	: ? :	1;
?	?	x	0	: 1 :	1;
(x1)	1	0	0	: 0 :	0;
(x1)	0	0	0	: 1 :	1;
(0x)	1	0	0	: 0 :	0;
(0x)	0	0	0	: 1 :	1;
?	? 	1 	? 	: ? : 	1;
?	? 	0 	1 	: ? : 	0;
n	? 	0 	0	: ? : 	-;
?	*  	? 	? 	: ? : 	-;
? 	? 	(?0) 	? 	: ? : 	-;
?	? 	? 	(?0)	: ? : 	-;
?	? 	?	?	: ? : 	x;
endtable
endprimitive
