module JK_FF(CLK,J,K,Q,RS,SET);
input CLK,J,K,SET,RS;
output Q;
reg Q;

always @(posedge CLK or negedge RS or negedge SET)
begin
if(!RS)  	Q <= 1'b0;
else if(!SET) 	Q <= 1'b1;
else
   case({J,K})
2'b00 : 	Q <= Q;
2'b01 : 	Q <= 1'b0;
2'b10 : 	Q <= 1'b1;
2'b11 : 	Q <= ~Q;
default: 	Q<= 1'bx;
  endcase
end
endmodule
