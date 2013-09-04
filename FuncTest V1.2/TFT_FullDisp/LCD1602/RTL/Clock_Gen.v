// Clock_Gen.v
/****************为LCD_Drvier模块产生500Hz的时钟信号**************/
module Clock_Gen(clk_48M,rst,clk_LCD);
input   clk_48M,rst;                //rst为全局复位信号（高电平有效）              
output  clk_LCD;   
wire    clk_counter;
reg     [11:0]  cnt;                  //对时钟进行计数分频
wire    clk_equ;
reg     [9:0] count;
reg     clk_BUF;
parameter       counter= 50;     //多少分频
/********************************************************************************
** 模块名称：分频器
** 功能描述：通过计数器实现分频功能.
********************************************************************************/
always@(posedge clk_48M)
begin
 if(!rst)                            //低电平复位
  cnt <= 12'd0;
 else
 if(clk_equ)
  cnt <= 12'd0;
 else
     cnt <= cnt+1'b1;
end
assign clk_equ = (cnt==counter);
assign clk_counter = clk_equ;               
always @(posedge clk_counter or negedge rst)
begin                                   //利用计数器分频产生500Hz时钟
    if(!rst)
        begin 
            clk_BUF <= 1'b0;
            count <= 10'b0;
        end
    else
    begin   
        if(count == 10'd1000) 
            begin
                clk_BUF <= ~clk_BUF;
                count <= 10'b0;
            end     
        else
            begin
                clk_BUF <= clk_BUF;     //clk_BUF为500Hz的时钟信号
                count <= count + 1'b1;
            end
    end
end
assign  clk_LCD = clk_BUF;
//clk_LCD为LCD_Drvier模块所需要的500Hz的时钟信号
endmodule
