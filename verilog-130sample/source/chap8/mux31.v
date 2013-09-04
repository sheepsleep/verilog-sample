primitive mux31(Y,in0,in1,in2,s2,s1);
input in0,in1,in2,s2,s1;
output Y;
table
//in0 in1 in2 s2 s1 : Y
0   ?   ?    0   0  :  0;
1   ?   ?    0   0  :  1;
?   0   ?    0   1  :  0;
?   1   ?    0   1  :  1;
?   ?   0    1   ?  :  0;
?   ?   1    1   ?  :  1;
0   0   ?    0   ?  :  0;
1   1   ?    0   ?  :  1;
0   ?   0    ?   0  :  0;
1   ?   1    ?   0  :  1;
?   0   0    ?   1  :  0;
?   1   1    ?   1  :  1;
endtable
endprimitive
