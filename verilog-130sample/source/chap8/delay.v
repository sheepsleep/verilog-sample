module delay(out,a,b,c);
output out;
input a,b,c;
and a1(n1,a,b);
or o1(out,c,n1);
specify
(a=>out)=2;
(b=>out)=3;
(c=>out)=1;
endspecify
endmodule
