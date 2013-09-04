module mux_casez(out,a,b,c,d,select);
output out;
input a,b,c,d;
input[3:0] select;
reg out;

always @(select or a or b or c or d)
begin
casez(select)
4'b???1: out = a;
4'b??1?: out = b;
4'b?1??: out = c;
4'b1???: out = d;
endcase
end
endmodule
