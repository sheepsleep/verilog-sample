module mpc(instr,out);
input[17:0] instr;
output[8:0] out;
reg[8:0] out;
reg func;
reg[7:0] op1,op2;

function[16:0] code_add;
input[17:0] instr;
reg add_func;
reg[7:0] code,opr1,opr2;
begin
code=instr[17:16];
opr1=instr[7:0];
case(code)
 2'b00:
	begin
	add_func=1;
	opr2=instr[15:8];
	end
 2'b01:
	begin
  	add_func=0;
 	opr2=instr[15:8];
	end
 2'b10:
	begin
  	add_func=1;
  	opr2=8'd1;
	end
 default:
	begin
 	add_func=0;
 	opr2=8'd1;
	end
 endcase
code_add={add_func,opr2,opr1};
end
endfunction
 
always @(instr)
begin
{func,op2,op1}=code_add(instr);
if(func==1)  out=op1+op2;
else         out=op1-op2;
end
endmodule
