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
