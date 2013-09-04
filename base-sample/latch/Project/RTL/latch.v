module latch8 ( 
             //input 
             oe_n      ,
             le        ,
             data_in   ,
             //output 
             data_out );

// I/O端口声明 
input        oe_n             ; // 三态使能信号
input        le               ; // 锁存使能信号 
input  [7:0] data_in          ; // 8位数据输入 
output [7:0] data_out         ; // 8位数据输出 
reg    [7:0] data_out         ;

//******************************************************** 
// 功能描述：完成八位锁存器的功能 
//******************************************************** 

always @ (*) begin 
	if ( oe_n == 1'b1 )    // 输出高阻 
	   data_out = 8'hzz; 
    else if ( le == 1'b1 ) // 数据透明输出
	   data_out = data_in;
    else ;
end

endmodule 
