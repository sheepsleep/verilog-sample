module cycle(c,u,clk);
output[6:0] c;
input[3:0] u;
input clk;
reg[2:0] i;
reg d0,d1,d2,temp;
reg[6:0] c;

always @(posedge clk)
begin
d0=0;
d1=0;
d2=0;
for (i=0;i<4;i=i+1)
begin
temp = d2 ^ c[i];
d2 = d1;
d1 = d0 ^ temp;
d0 = temp;
c[i] = u[i];
end
for (i=4;i<7;i=i+1)
begin
temp = d2;
d2 = d1;
d1 = d0 ^ temp;
d0 = temp;
c[i] = temp;
end
end

endmodule
