/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           1602 LCD Driver Program
** Last modified Date:  2009-10-18
** Last Version:        1.0
** Descriptions:        driver 1602 LCD 
**------------------------------------------------------------------------------------------------------
** Created by:          LCD1602_TOP
** Created date:        2011-09-18
** Version:             1.0
** Descriptions:        The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/

//功能简述：在1602液晶模块上显示字符串，其中第一行显示“Welcome to LCD"
//                                        在第二行显示“ by DongDong  "
//液晶模块为1602A，相关特性请参考其数据手册

module LCD_Driver  (
// input
input                clk_lcd   ,
input                rst       ,

// output
output  wire         LCD_EN     ,
output  reg          RS         ,
output  wire         RW         ,
output  reg [7:0]    DB8          );

//LCD_EN为LCD模块的使能信号（下降沿触发）
//RS=0时为写指令；RS=1时为写数据
//RW=0时对LCD模块执行写操作；RW=1时对LCD模块执行读操作

reg     [111:0] Data_First_Buf,Data_Second_Buf;              //液晶显示的数据缓存
reg     LCD_EN_Sel                            ;
reg     [3:0] disp_count                      ;
reg     [3:0] state                           ;
parameter     Clear_Lcd = 4'b0000             ,              //清屏并光标复位 
              Set_Disp_Mode = 4'b0001         ,              //设置显示模式：8位2行5x7点阵   
           	  Disp_On = 4'b0010               ,              //显示器开、光标不显示、光标不允许闪烁
              Shift_Down = 4'b0011            ,              //文字不动，光标自动右移
              Write_Addr = 4'b0100            ,              //写入显示起始地址
              Write_Data_First = 4'b0101      ,              //写入第一行显示的数据
              Write_Data_Second = 4'b0110     ,              //写入第二行显示的数据
              Idel = 4'b0111;                                //空闲状态
parameter     Data_First  = "Welcome to LCD",                //液晶显示的第一行的数据
              Data_Second = "  by DongDong  ";               //液晶显示的第二行的数据          
       

assign  RW = 1'b0;                                           //RW=0时对LCD模块执行写操作
assign  LCD_EN = LCD_EN_Sel ? clk_lcd : 1'b0;                //通过LCD_EN_Sel信号来控制LCD_EN的开启与关闭

always @(posedge clk_lcd or negedge rst)
begin
   if(!rst)
      begin
          state <= Clear_Lcd;                               //复位：清屏并光标复位   
          RS <= 1'b0;                                       //复位：RS=0时为写指令；                       
          DB8 <= 8'b0;                                      //复位：使DB8总线输出全0
          LCD_EN_Sel <= 1'b1;                               //复位：开启夜晶使能信号

          disp_count <= 4'b0;
      end
   else 
      case(state)                                           //初始化LCD模块
      Clear_Lcd:
             begin
                state <= Set_Disp_Mode;
                DB8 <= 8'b00000001;                         //清屏并光标复位   
             end
      Set_Disp_Mode:
             begin
                state <= Disp_On;
                DB8 <= 8'b00111000;                         //设置显示模式：8位2行5x8点阵         
             end
      Disp_On:
             begin
                state <= Shift_Down;
                DB8 <= 8'b00001100;                         //显示器开、光标不显示、光标不允许闪烁    
             end
      Shift_Down:
            begin
                state <= Write_Addr;
                DB8 <= 8'b00000110;                         //文字不动，光标自动右移    
            end
      Write_Addr:
            begin
                state <= Write_Data_First;
                DB8 <= 8'b10000001;                         //写入第一行显示起始地址：第一行第二个位置    
                Data_First_Buf <= Data_First;               //将第一行显示的数据赋给Data_First_Buf?
            end
      Write_Data_First:                                     //写第一行数据
            begin
                if(disp_count == 14)                        //disp_count等于14时表示第一行数据已写完
                    begin
                        DB8 <= 8'b11000001;                 //送入写第二行的指令
                        RS <= 1'b0;
                        disp_count <= 4'b0; 
                        Data_Second_Buf <= Data_Second;
                        state <= Write_Data_Second;         //写完第一行进入写第二行状态
                    end
                else
                    begin
                        DB8 <= Data_First_Buf[111:104];
                        Data_First_Buf <= (Data_First_Buf << 8);
                        RS <= 1'b1;                         //RS=1表示写数据
                        disp_count <= disp_count + 1'b1;
                        state <= Write_Data_First; 
                    end
            end
      Write_Data_Second:                                    //写第二行数据
            begin
                if(disp_count == 14)
                    begin
                        LCD_EN_Sel <= 1'b0;
                        RS <= 1'b0;
                        disp_count <= 4'b0; 
                        state <= Idel;                      //写完进入空闲状态
                    end
                else
                    begin
                        DB8 <= Data_Second_Buf[111:104];
                        Data_Second_Buf <= (Data_Second_Buf << 8);
                        RS <= 1'b1;
                        disp_count <= disp_count + 1'b1;
                        state <= Write_Data_Second; 
                    end              
            end
      Idel:     
            begin
                state <=  Idel;                             //在Idel状态循环  
            end
      default:  state <= Clear_Lcd;                         //若state为其他值，则将state置为Clear_Lcd 
      endcase 
end
endmodule


