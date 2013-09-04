module mux2_1b(out,a,b,sel);
output out;
input a,b,sel;
reg out;
always @(a or b or sel)
begin
    if(sel) out = b;
    else    out = a;
end
endmodule
