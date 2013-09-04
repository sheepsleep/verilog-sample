module decoder1(c,y,clk);
output[6:0] c;
input[6:0] y;
input clk;
reg[2:0] s;
reg[6:0] e,c;

always @(posedge clk)
begin
s[0] = y[0] ^ y[3] ^ y[5] ^ y[6];
s[1] = y[1] ^ y[3] ^ y[4] ^ y[5];
s[2] = y[2] ^ y[4] ^ y[5] ^ y[6];
e[0] = s[0] & (~s[1]) & (~s[2]);
e[1] = (~s[0]) & s[1] & (~s[2]);
e[2] = (~s[0]) & (~s[1]) & s[2];
e[3] = s[0] & s[1] & (~s[2]);
e[4] = (~s[0]) & s[1] & s[2];
e[5] = s[0] & s[1] & s[2];
e[6] = s[0] & (~s[1]) & s[2];
c = e ^ y;
end
endmodule
