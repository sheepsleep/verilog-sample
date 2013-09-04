module linear(c,u,clk);
output[6:0] c;
input[3:0] u;
input clk;
reg[6:0] c;

always @(posedge clk)
begin
c[6] = u[3];
c[5] = u[2];
c[4] = u[1];
c[3] = u[0];
c[2] = u[1] ^ u[2] ^ u[3];
c[1] = u[0] ^ u[1] ^ u[2];
c[0] = u[0] ^ u[2] ^ u[3] ;
end
endmodule
