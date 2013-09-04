module paobiao(CLK,CLR,PAUSE,MSH,MSL,SH,SL,MH,ML);
input CLK,CLR;
input PAUSE;
output[3:0] MSH,MSL,SH,SL,MH,ML;
reg[3:0] MSH,MSL,SH,SL,MH,ML;
reg cn1,cn2;

always @(posedge CLK or posedge CLR)
begin
if(CLR)  begin
	{MSH,MSL}<=8'h00;
	cn1<=0;
	end
else 	if(!PAUSE)
	begin
	if(MSL==9)  begin
	MSL<=0;
	if(MSH==9) 
	begin  MSH<=0;  cn1<=1;  end
	else  MSH<=MSH+1;
	end
	else	begin
	MSL<=MSL+1;  cn1<=0;
	end
	end
end

always @(posedge cn1 or posedge CLR)
begin
	if(CLR)  begin
	{SH,SL}<=8'h00;
	cn2<=0;
	end
	else	if(SL==9)
	begin
	SL<=0;
	if(SH==5)
		begin  SH<=0;  cn2<=1;  end
	else  		SH<=SH+1;
	end
	else 
	begin  SL<=SL+1;  cn2<=0;  end
end

always @(posedge cn2 or posedge CLR)
begin
	if(CLR)
	begin  {MH,ML}<=8'h00;  end
	else  if(ML==9)	begin
	ML<=0;
	if(MH==5)  	MH<=0;
	else  		MH<=MH+1;
	end
	else  	ML<=ML+1;
end
endmodule
