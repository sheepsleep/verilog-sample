module block1(Q0,Q1,Q2,Q3,din,clk);
output Q0,Q1,Q2,Q3;
input clk,din;
reg Q0,Q1,Q2,Q3;

always @(posedge clk)
    	begin
    	Q3=Q2;
	Q2=Q1;
	Q1=Q0;
	Q0=din;
   	end
endmodule
