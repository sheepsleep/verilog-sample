module count(data,clk,reset,load,cout,qout);
output cout;
output[3:0] qout;
reg[3:0] qout;
input[3:0] data;
input clk,reset,load;
	
always @(posedge clk)
begin
if (!reset)  	qout= 4'h00;
else if (load)  qout= data;
else   		qout=qout + 1;
end

assign cout=(qout==4'hf)?1:0;
endmodule
