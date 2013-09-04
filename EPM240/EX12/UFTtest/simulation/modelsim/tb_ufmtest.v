


`timescale 1ns/1ns
module tb_ufmtest();

//inout
wire[15:0] databus;		//Flash数据总线

//input
wire data_valid;		//Flash数据输出有效信号
wire nbusy;				//Flash忙信号

//output
reg[8:0] addr;			//Flash地址总线
reg nerase;				//擦除Flash某一扇区信号
reg nread;				//读Flash信号
reg nwrite;				//写Flash信号

reg[15:0] databus_r;	//测试模块数据总线寄存器
reg[15:0] rdback_data;	//测试模块数据总线数据回读寄存器

assign databus = nwrite ? 16'hzzzz:databus_r;

ufmtest		ufmtest(
				.databus(databus),
				.addr(addr),
				.nerase(nerase),
				.nread(nread),
				.nwrite(nwrite),
				.data_valid(data_valid),
				.nbusy(nbusy)
			);


parameter	DELAY_600US	= 600_000,		//600us延时
			DELAY_2US	= 2_000,		//2us延时
			DELAY_5US	= 5_000;		//5us延时


initial begin
		nerase = 1;
		nread = 1;
		nwrite = 1;
		addr = 0;
		databus_r = 0;
	
	#DELAY_600US;	//0地址写入数据99
		databus_r = 99;
		addr = 9'd0;
		nwrite = 0;
		#DELAY_5US;		
		nwrite = 1;		
		@ (posedge nbusy);

			
	#DELAY_5US;	//0地址读出数据，保存到寄存器rdback_data中
		databus_r = 16'hff;
		addr = 9'd0;
		nread = 0;
		#DELAY_5US;		
		nread = 1;		
		@ (posedge data_valid);
		rdback_data = databus; 
			
	#DELAY_600US;
	$stop;		
end


endmodule
