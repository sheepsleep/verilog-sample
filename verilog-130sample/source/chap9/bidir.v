module bidir(tri_inout,out,in,en,b);
inout tri_inout;
output out;
input in,en,b;
assign tri_inout = en ? in : 'bz;
assign out = tri_inout ^ b;
endmodule
