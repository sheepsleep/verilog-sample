module correlator(out,a,b,clk);
output[4:0] out;
input[15:0] a,b;
input clk;
wire[2:0] sum1,sum2,sum3,sum4;
wire[3:0] temp1,temp2;

detect	u1(sum1,a[3:0],b[3:0],clk),
	u2(sum2,a[7:4],b[7:4],clk),
	u3(sum3,a[11:8],b[11:8],clk),
	u4(sum4,a[15:12],b[15:12],clk);
add3 	u5(temp1,sum1,sum2,clk),
	u6(temp2,sum3,sum4,clk);
add4 	u7(out,temp1,temp2,clk);
endmodule

module detect(sum,a,b,clk);
output[2:0] sum;
input clk;
input[3:0] a,b;
wire[3:0] ab;
reg[2:0] sum;

assign ab = a ^ b;

always @(posedge clk)
  begin
	case(ab)
	'd0: sum = 4;
	'd1,'d2,'d4,'d8:  sum = 3;
	'd3,'d5,'d6,'d9,'d10,'d12: sum = 2;
	'd7,'d11,'d13,'d14: sum = 1;	
	'd15: sum = 0;
	endcase
  end
endmodule

module add3(add,a,b,clk);
output[3:0] add;
input[2:0] a,b;
input clk;
reg[3:0] add;
always @(posedge clk)
begin  add = a + b;  end
endmodule

module add4(add,a,b,clk);
output[4:0] add;
input[3:0] a,b;
input clk;
reg[4:0] add;

always @(posedge clk)
begin  add = a + b;  end
endmodule
