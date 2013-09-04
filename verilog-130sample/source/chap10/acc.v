module acc(accout,cout,accin,cin,clk,clear);
output[7:0] accout;
output cout;
input[7:0] accin;
input cin,clk,clear;
wire[7:0] sum;

add8 accadd8(sum,cout,accout,accin,cin);
reg8 accreg8(accout,sum,clk,clear);

endmodule

module add8(sum,cout,b,a,cin);
output[7:0] sum;
output cout;
input[7:0] a,b;
input cin;
assign {cout,sum}=a+b+cin;
endmodule

module reg8(qout,in,clk,clear);
output[7:0] qout;
input[7:0] in;
input clk,clear;
reg[7:0] qout;
always @(posedge clk or posedge clear)
    begin
	if(clear)  	qout=0;
	else  		qout=in;
    end
endmodule
