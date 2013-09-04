module sell(one_dollar,half_dollar,collect,half_out,dispense,reset,clk);
parameter idle=0,one=2,half=1,two=3,three=4;
input one_dollar,half_dollar,reset,clk;
output collect,half_out,dispense;
reg collect,half_out,dispense;
reg[2:0] D;

always @(posedge clk)
  begin
	if(reset)
			begin
			dispense=0;		collect=0;
			half_out=0;		D=idle;
			end
	case(D)
	idle: 
			if(half_dollar)	 D=half;
			else  if(one_dollar)	
			D=one;
	half:
			if(half_dollar)	 D=one;
			else if(one_dollar)
			D=two;
	one:
			if(half_dollar)	D=two;
			else if(one_dollar)  
			D=three;
	two:
			if(half_dollar)	D=three; 
  			else if(one_dollar) 
			begin
			dispense=1;
			collect=1;	D=idle;
			end
	three:
			if(half_dollar)	
			begin
			dispense=1;
			collect=1;	D=idle;
			end
			else if(one_dollar)
			begin
			dispense=1;
			collect=1;
			half_out=1;	D=idle;
			end
	endcase
  end
endmodule