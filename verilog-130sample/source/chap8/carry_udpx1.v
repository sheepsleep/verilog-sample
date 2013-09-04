primitive carry_udpx1(cout,cin,a,b);
input cin,a,b;
output cout;
table
// cin  a  b  :  cout
0   0   0  :    0;
0   1   0  :    0;
0   0   1  :    0;
0   1   1  :    1;
1   0   0  :    0;
1   0   1  :    1;
1   1   0  :    1;
1   1   1  :    1;
0   0   x  :    0;
0   x   0  :    0;
x   0   0  :    0;
1   1   x  :    1;
1   x   1  :    1;
x   1   1  :    1;
endtable
endprimitive
