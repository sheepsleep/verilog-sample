module MUX21_2(out,a,b,sel);
input a,b,sel;
output out;
reg out;
always@(a or b or sel)
  begin
     if(sel==0) out=a;
     else       out=b;
  end
endmodule
