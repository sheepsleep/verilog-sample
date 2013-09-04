module mux2_1a(out,a,b,sel);
output out;
input a,b,sel;
not (sel_,sel);
and (a1,a,sel_),
    (a2,b,sel);
or  (out,a1,a2);
endmodule
