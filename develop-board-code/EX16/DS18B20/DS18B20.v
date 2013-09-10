////////////////////////////////////////////////////////////////////////////////
//  Company: 成都锐创智能科技 Ruichuang Smart Technology                      //
//           http://ruicstech.taobao.com                                      // 
//  Engineer:      Youzhiyu                                                   //
//  QQ      :      4016682                                                    //
//  Target Device: MAXII240T100C5N                                            //
//  Tool versions: Quartus II 7.2                                             //
//  Create Date:   2011-09-06 10:09                                           //
//  Description:                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved                //
//----------------------------------------------------------------------------//
////////////////////////////////////////////////////////////////////////////////


module DS18B20(nReset,ClkEnable,rd,clk,data,icdata);

input nReset,ClkEnable,rd,clk;//clk 1Mhz
output [7:0] data;
inout icdata;

reg [7:0] data;
reg icdata;
initial data = 8'bzzzzzzzz; 

parameter state_0 	= 0;
parameter state_1 	= 1;
parameter state_2 	= 2;
parameter state_3 	= 3;
parameter state_4 	= 4;
parameter state_5 	= 5;
parameter state_6 	= 6;
parameter state_7 	= 7;
parameter state_8 	= 8;
parameter state_9 	= 9;
parameter state_10 	= 10;
parameter state_11 	= 11;
parameter state_12 	= 12;
parameter state_13 	= 13;
parameter state_14 	= 14;
parameter state_15 	= 15;

always@(negedge clk or negedge nReset)
begin
	if(!nReset)
	begin
	end
	else if(ClkEnable)
	begin
		CmdSETDS18B20;		
	end		
end

reg [7:0] inter_bus_in;
always@(rd)
begin
 if(!rd)
	inter_bus_in <= Result;	
  else 
     inter_bus_in <= 8'bzzzzzzzz;

	data <= inter_bus_in;
end	

reg Flag_Rst;									//复位完成标志
reg [4:0] Rststate;								//复位状态	
reg [10:1] CountRstStep;						//复位计数器 1024
task Rst_DS18B20;
begin
	case(Rststate)
	state_0 : 									//out 1 ,keep 1us
	begin
		Flag_Rst <= 0;							//复位进行中
		icdata <= 1;							//总线拉高
		Rststate <= state_1;
		CountRstStep <= 0;
	end	
	state_1 : 
	begin
		icdata <= 0;							//总线拉低
		if(CountRstStep > 600)					//拉低时间600us
		begin
			CountRstStep <= 0;					//计数器清0
			Rststate <= state_2;				
		end	
		else	
		begin			
			CountRstStep <= CountRstStep + 1;	
			Rststate <= state_1;				//计时未到
		end
	end	
	state_2 :									
	begin
		icdata <= 1;							//总线拉高
		if(CountRstStep > 50)					//拉高时间50us
		begin
			CountRstStep <= 0;					//计数器清0
			Rststate <= state_3;
		end
		else
		begin
			CountRstStep <= CountRstStep + 1;
			Rststate <= state_2;				//计时未到
		end		
	end
	state_3	:
	begin
		icdata <= 1'bz;							//释放总线
		Rststate <= state_4;
	end
	state_4 :
	begin
		Rststate <= state_5;
	end
	state_5 :
	begin
		if(icdata == 1)							//初始化完成
		begin
			CountRstStep <= 0;
			Rststate <= state_6;				//结束			
		end
		else
		begin
			if(CountRstStep > 300)
			begin
				CountRstStep <= 0;
				Rststate <= state_0;
			end
			else
			begin
				CountRstStep <= CountRstStep + 1;
				Rststate <= state_5;
			end	
		end
	end
	state_6 :
	begin
		if(CountRstStep == 200)
		begin
			CountRstStep <= 0;
			Rststate <= state_7;		
		end
		else
		begin
			CountRstStep <= CountRstStep + 1;
			Rststate <= state_6;		
		end
	end	
	state_7 :
	begin
		Flag_Rst <= 1;							//初始化完成
		CountRstStep <= 0;
		Rststate <= state_0;					//回到原点
	end
	default : 
	begin
		Rststate <= state_0;						 
		CountRstStep <= 0;
	end	
	endcase
end
endtask

reg[3:0] i;					//一个字8个位，多出一个数量级已用于判断

reg Flag_Write;							//写命令完成标志与写位
reg[4:0] Writestate;							//写命令状态
task Write_DS18B20;
input [7:0] dcmd;								//命令
reg[7:0] indcmd;
reg wBit;
begin
	case(Writestate)
	state_0 :
	begin
		Flag_Write <= 0;						//写命令过程中
		Writestate <= state_1;	
		indcmd <= dcmd;	
		i <= 0;		
	end
	state_1 :
	begin				
		if(i < 8)
		begin
//			wBit <= dcmd & 1;					//命令取1位
			wBit_DS18B20(indcmd[0]);	
			if(Flag_wBit)						//写完1位
			begin
				indcmd = indcmd >> 1;		//右移1位
				i <= i + 1;						//位数加1
			end
			Writestate <= state_1;				//重复加写位
		end
		else 									//写完8位
		begin
			Writestate <= state_2;				
			i <= 0;
		end	
	end
	state_2 :
	begin
		Flag_Write <= 1;						//写命令完毕
		indcmd <= 0;
		Writestate <= state_0;
	end
	default :
	begin
		Flag_Write <= 0;
		Writestate <= state_0;
	end
	endcase
end
endtask	

reg Flag_wBit;									//写位完成标志
reg[4:0] WriteBitstate;							//写位命令
reg[8:1] CountWbitStep;							//写位计数器
task wBit_DS18B20;
input wiBit;										//位信息
begin
	case(WriteBitstate)
	state_0 :
	begin
		Flag_wBit <= 0;							//写位进行中
		icdata <= 1;							//总线拉高
		WriteBitstate <= state_1;
		CountWbitStep <= 0;
	end	
	state_1 :
	begin
		icdata <= 0;							//总线拉低
		if(wiBit)WriteBitstate <= state_2;		//写1的命令
		else WriteBitstate <= state_4;			//写0的命令
	end	
	state_2 :
	begin
		if(CountWbitStep >= 3)					//维持低电平3us
		begin
			CountWbitStep <= 0;
			icdata <= 1;						//拉高电平
			WriteBitstate <= state_3;
		end
		else
		begin
			CountWbitStep <= CountWbitStep + 1;	//继续计数
			WriteBitstate <= state_2;
		end	
	end
	state_3 :
	begin
		if(CountWbitStep >= 60)					//维持拉高电平60us
		begin
			CountWbitStep <= 0;
			WriteBitstate <= state_6;
		end
		else
		begin
			CountWbitStep <= CountWbitStep + 1;	//继续计数
			WriteBitstate <= state_3;
		end	
	end	
	state_4 :
	begin
		if(CountWbitStep >= 60)					//维持低电平60us
		begin
			CountWbitStep <= 0;
			WriteBitstate <= state_5;
		end
		else
		begin
			icdata <= 0;
			CountWbitStep <= CountWbitStep + 1;
			WriteBitstate <= state_4;
		end			
	end
	state_5 :
	begin
		if(CountWbitStep >= 3)					//拉高总线3us
		begin
			CountWbitStep <= 0;
			WriteBitstate <= state_6;
		end
		else
		begin
			icdata <= 1;
			CountWbitStep <= CountWbitStep + 1;
			WriteBitstate <= state_5;
		end			
	end	
	state_6 :									
	begin
		Flag_wBit <= 1;							//写位命令完毕
		CountWbitStep <= 0;
		WriteBitstate <= state_0;
	end
	default :
	begin
		Flag_wBit <= 0;
		CountWbitStep <= 0;
		WriteBitstate <= state_0;	
	end	
	endcase
end
endtask

reg[3:0] j;
reg[7:0] ResultDS18B20;	//读到的结果
reg Flag_Read;									//读命令标志
reg [16:1] Readstate;							//读命令状态
task Read_DS18B20;
begin
	case(Readstate)
	state_0 : 
	begin
		Flag_Read <= 0;							//读命令进行中
		Readstate <= state_1;
		j <= 1;
	end
	state_1 :
	begin
		rBit_DS18B20;
		if(Flag_rBit)
		begin
			if(temp)ResultDS18B20 = ResultDS18B20 | 8'b1000_0000;
			if(j < 8)
			begin
				ResultDS18B20 = ResultDS18B20 >> 1;	
				j <= j  + 1;
				Readstate <= state_1;
			end	
			else
			begin
				Readstate <= state_2;				//读完1个byte
				j <= 1;
			end			
		end
		else Readstate <= state_1;		
	end
	state_2 :	
	begin
		Flag_Read <= 1;							//读命令完成
		Readstate <= state_0;
	end
	default :	
	begin
		Flag_Read <= 0;
		Readstate <= state_0;
	end
	endcase
end	
endtask			

reg Flag_rBit,temp;									//读位命令标志
reg[16:1] ReadBitstate;							//读位命令状态
reg[6:1] CountRbitStep;							//读位命令计时器
task rBit_DS18B20;
begin
	case(ReadBitstate)
	state_0 :
	begin
		Flag_rBit <= 0;							//读位命令进行中
		icdata <= 1;							//总线拉高
		CountRbitStep <= 0;
		ReadBitstate <= state_1;
	end
	state_1 :
	begin
		if(CountRbitStep >= 3)					//保持低电平3us
		begin
			icdata <= 1;						//再将总线拉高
			icdata <= 1'bz;						//改为输入
			CountRbitStep <= 0;
			ReadBitstate <= state_2;
		end
		else
		begin
			icdata <= 0;						//总线拉低
			CountRbitStep <= CountRbitStep + 1;
			ReadBitstate <= state_1;
		end		
	end
	state_2 :
	begin
		if(CountRbitStep >= 10)					//维持输入状态10us
		begin
			if(icdata)temp <= 1;				//输出1
			else temp <= 0;						//输出0
			CountRbitStep <= 0;
			ReadBitstate <= state_3;
		end
		else
		begin
			CountRbitStep <= CountRbitStep + 1;
			ReadBitstate <= state_2;			
		end
	end
	state_3 :
	begin
		if(CountRbitStep >= 60)					//维持60us输入
		begin
			CountRbitStep <= 0;
			ReadBitstate <= state_4;	
		end
		else
		begin
			CountRbitStep <= CountRbitStep + 1;
			ReadBitstate <= state_3;	
		end					
	end
	state_4 :
	begin
		Flag_rBit <= 1;							//读位命令完毕
		CountRbitStep <= 0;
		ReadBitstate <= state_0;	
	end
	default :
	begin
		Flag_rBit <= 0;
		CountRbitStep <= 0;
		ReadBitstate <= state_0;		
	end
	endcase
end	
endtask	

reg Flag_CmdSET;
reg [16:1] CmdSETstate;
reg [16:1] Count65535;
reg [4:1] Count12;
reg [7:0] Resultl,Resulth,Result;
task CmdSETDS18B20;
begin
	case(CmdSETstate)
	state_0 :
	begin
		Flag_CmdSET <= 0;
		Rst_DS18B20;
		if(!Flag_Rst)CmdSETstate <= state_0;
		else CmdSETstate <= state_1;	
	end
	state_1 :
	begin
//		Write_DS18B20(8'hcc);//
		Write_DS18B20(8'h44);
		if(!Flag_Write)CmdSETstate <= state_1;
		else CmdSETstate <= state_2;
	end
	state_2 :	
	begin
//		Write_DS18B20(8'h44);//
		Write_DS18B20(8'hcc);
		if(!Flag_Write)CmdSETstate <= state_2;
		else CmdSETstate <= state_3;
	end
	state_3 :
	begin
		if(Count65535 == 65535)
		begin
			Count65535 <= 0;
			CmdSETstate <= state_4;
		end
		else
		begin
			Count65535 <= Count65535 + 1;
			CmdSETstate <= state_3;
		end				
	end
	state_4 :
	begin
		if(Count12 == 12)
		begin
			Count12 <= 0;
			CmdSETstate <= state_5;
		end
		else
		begin
			Count12 <= Count12 + 1;
			CmdSETstate <= state_3;
		end				
	end		
	state_5 :
	begin
		Rst_DS18B20;
		if(!Flag_Rst)CmdSETstate <= state_5;
		else CmdSETstate <= state_6;		
	end
	state_6 :
	begin
//		Write_DS18B20(8'hcc);//
		Write_DS18B20(8'hbe);
		if(!Flag_Write)CmdSETstate <= state_6;
		else CmdSETstate <= state_7;
	end	
	state_7 :	
	begin
//		Write_DS18B20(8'hbe);//
		Write_DS18B20(8'hcc);
		if(!Flag_Write)CmdSETstate <= state_7;
		else CmdSETstate <= state_8;
	end	
	state_8 :
	begin
		Read_DS18B20;
		if(!Flag_Read)CmdSETstate <= state_8;
		else 
		begin
			Resultl = ResultDS18B20;
			CmdSETstate <= state_9;
		end	
	end		
	state_9 :
	begin
		Read_DS18B20;
		if(!Flag_Read)CmdSETstate <= state_9;
		else 
		begin
			Resulth = ResultDS18B20;
			CmdSETstate <= state_10;
		end	
	end		
	state_10 :
	begin
		Result = (Resulth << 4)|(Resultl >> 4);
		CmdSETstate <= state_11;
	end	
	state_11 :	
	begin
		Flag_CmdSET <= 1;
		CmdSETstate <= state_0;
	end
	default :
	begin
		Flag_CmdSET <= 0;
		CmdSETstate <= state_0;	
	end
	endcase
end
endtask
endmodule