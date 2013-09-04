module control(std_f_sel,reset,clk,clear,cntover,cntlow);
output[1:0] std_f_sel;
output reset;
input clk,clear,cntover,cntlow;
reg[1:0] std_f_sel;
reg reset;
reg[5:0] present,next;
parameter start_fl00k=6'b000001,	
  	  fl00k_cnt=6'b000010,
  	  start_fl0k=6'b000100,
  	  fl0k_cnt=6'b001000,
  	  start_flk=6'b010000,
  	  flk_cnt=6'b100000;

always @(posedge clk or posedge clear)
begin
	if(clear) 	present<=start_fl0k;
	else 		present<=next;
end

always @(present or cntover or cntlow)
begin
case(present)
start_fl00k:		next<=fl00k_cnt;
fl00k_cnt:
	begin
	if(cntlow) 	next<=start_fl0k;
	else 		next<=fl00k_cnt;
	end
start_fl0k:		next<=fl0k_cnt;
fl0k_cnt:
	begin
	if(cntlow) 	next<=start_flk;
	else  if(cntover)  	next<=start_fl00k;
	else  		next<=fl0k_cnt;
	end
start_flk:		next<=flk_cnt;
flk_cnt:
	begin
	if(cntover) 	next<=start_fl0k;
	else  		next<=flk_cnt;
	end
default:		next<=start_fl0k;
endcase
end

always @(present)
begin
case(present)
start_fl00k:	begin	reset=1;  std_f_sel=2'b00;  end
fl00k_cnt:	begin	reset=0;  std_f_sel=2'b00;  end
start_fl0k:	begin	reset=1;  std_f_sel=2'b01;  end
fl0k_cnt:	begin	reset=0;  std_f_sel=2'b01;  end
start_flk:	begin 	reset=1;  std_f_sel=2'b11;  end
flk_cnt:	begin	reset=0;  std_f_sel=2'b11;  end
default:	begin	reset=1;  std_f_sel=2'b01;  end
endcase
end
endmodule
