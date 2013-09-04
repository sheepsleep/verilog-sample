module fir(clk,x,y);
input[7:0] x;
input clk;
output[15:0] y;
reg[15:0] y;
reg[7:0] tap0,tap1,tap2,tap3,tap4,tap5,tap6,tap7,tap8,tap9,tap10;
reg[7:0] t0,t1,t2,t3,t4,t5;
reg[15:0] sum;

always@(posedge clk)
  begin
	t0<=tap5;
   	t1<=tap4+tap6;
   	t2<=tap3+tap7;
   	t3<=tap2+tap8;
   	t4<=tap1+tap9;
	t5<=tap0+tap10;
   	
   	sum<=(t1<<4)+{t1[7],t1[7:1]}+{t1[7],t1[7],t1[7:2]}+{t1[7],t1[7],t1[7],
	t1[7:3]}-(t2<<3)-(t2<<2)+t2-{t2[7],t2[7],t2[7:2]}
	+(t3<<2)+t3+{t3[7],t3[7],t3[7:2]}+{t3[7],t3[7],t3[7],t3[7],t3[7:4]}
	+{t3[7],t3[7],t3[7],t3[7],t3[7],t3[7:5]}
	-t4-{t4[7],t4[7:1]}-{t4[7],t4[7],t4[7],t4[7:3]}
	+{t5[7],t5[7:1]}-{t5[7],t5[7],t5[7],t5[7],t5[7],t5[7:5]}
	+(t0<<7)-((t0<<2)<<2)-(t0<<2)+{t0[7],t0[7:1]}
	+{t0[7],t0[7],t0[7:2]}+{t0[7],t0[7],t0[7],t0[7],t0[7:4]};
	
	tap10<=tap9;
   	tap9<=tap8;
   	tap8<=tap7;
   	tap7<=tap6;
   	tap6<=tap5;
   	tap5<=tap4;
   	tap4<=tap3;
   	tap3<=tap2;
   	tap2<=tap1;
   	tap1<=tap0;
   	tap0<=x;
   
	y<={sum[15],sum[15],sum[15],sum[15],sum[15],sum[15],sum[15],sum[15:7]};
  end
endmodule

