module account(state,clk,card,decide,disptime,dispmoney,
write,read,warn,cut);
output write,read,warn,cut;
input state,clk,card;
input[2:1] decide;
output[10:0] dispmoney;
output[8:0] disptime;
reg[10:0] money; 
reg[8:0] dtime;
reg warn,cut,write,t1m;
reg set,reset_ena;
integer num1,temp;

assign  dispmoney=card?money:0;
assign  disptime=dtime;
assign  read=card?1:0;

always @(posedge clk)
begin
	if (num1==59)  begin  num1<=0;  t1m<=1;  end
	else 	begin
	if(state)	num1<=num1+1;
	else  		num1<=0;  t1m<=0; 
	end
end

always @(negedge clk)
begin
  	if(!set)
   	begin  money<=11'h500;  set<=1;  end
  	if(card&state)
     	if(t1m)
     	case({state,decide})
   	3'b101: 	if(money<3)
	begin  warn<=1;  write<=0;  reset_ena<=1;  end
	else
	begin
	if(money[3:0]<4'b0011)
	begin
	money[3:0]<=money[3:0]+7;
	if(money[7:4]!=0)
	money[7:4]<=money[7:4]-1;
	else
	begin  money[7:4]<=9;  money[10:8]<=money[10:8]-1;  end
	end
	else  money[3:0]<=money[3:0]-3;  write<=1; 
	if(dtime[3:0]==9)
	begin
	dtime[3:0]<=0;
	if(dtime[7:4]==9)
	begin  dtime[7:4]<=0;  dtime[8]<=dtime[8]+1;  end
	else  dtime[7:4]<=dtime[7:4]+1;
	end
	else
	begin
	dtime[3:0]<=dtime[3:0]+1;  warn<=0;  reset_ena<=0;
	end
	end
    	3'b110:  if(money<6)
	begin  warn<=1;  write<=0;  reset_ena<=1;  end
	else begin
	if(dtime[3:0]==9)
	begin 
	dtime[3:0]<=0;  if(dtime[7:4]==9)
	begin  dtime[7:4]<=0;  dtime[8]<=dtime[8]+1;  end
	else dtime[7:4]<=dtime[7:4]+1;
	end
	else dtime[3:0]<=dtime[3:0]+1;
	if(money[3:0]<4'b0110)
	begin
	money[3:0]<=money[3:0]+4;
	if(!money[7:4])
	begin  money[7:4]<=9;  money[10:8]<=money[10:8]-1;  end
	else  money[7:4]<=money[7:4]-1;
	end
	else  money[3:0]<=money[3:0]-6;
	write<=1;  reset_ena<=0;   warn<=0;
	end 
	endcase
	else write<=0;
	else  begin  dtime<=0;  warn<=0;  write<=0;  reset_ena<=0;  end
end

always @(posedge clk)
  begin
if(warn)  temp<=temp+1;
else temp<=0;
if(temp==15)
begin  cut<=1;  temp<=0;  end
if(!card||!reset_ena)
begin
cut<=0;
temp<=0;
end
  end
endmodule