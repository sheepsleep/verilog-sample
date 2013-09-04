primitive carry_udpx2(cout,cin,a,b);
input cin,a,b;
output cout;
table
// cin  a  b :  cout
?   0   0  :    0;
0   ?   0  :    0;
0   0   ?  :    0;
?   1   1  :    1;
1   ?   1  :    1;
1   1   ?  :    1;
endtable
endprimitive
