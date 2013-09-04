module add_tree(out,a,b,clk);
output[15:0] out;
input[7:0] a,b;
input clk;
wire[15:0] out;
wire[14:0] out1,c1;
wire[12:0] out2;
wire[10:0] out3,c2;
wire[8:0] out4;
reg[14:0] temp0;
reg[13:0] temp1;
reg[12:0] temp2;
reg[11:0] temp3;
reg[10:0] temp4;
reg[9:0] temp5;
reg[8:0] temp6;
reg[7:0] temp7;

function[7:0] mult8x1;
input[7:0] operand;
input sel;
begin
mult8x1= (sel) ? (operand) : 8'b00000000;
end
endfunction

always @(posedge clk)
begin
temp7<=mult8x1(a,b[0]);
temp6<=((mult8x1(a,b[1]))<<1);
temp5<=((mult8x1(a,b[2]))<<2);
temp4<=((mult8x1(a,b[3]))<<3);
temp3<=((mult8x1(a,b[4]))<<4);
temp2<=((mult8x1(a,b[5]))<<5);
temp1<=((mult8x1(a,b[6]))<<6);
temp0<=((mult8x1(a,b[7]))<<7);
end

assign 	out1 = temp0 + temp1;
assign	out2 = temp2 + temp3; 
assign	out3 = temp4 + temp5;
assign	out4 = temp6 + temp7;
assign 	c1 = out1 + out2;
assign 	c2 = out3 + out4;
assign 	out = c1 + c2;

endmodule
