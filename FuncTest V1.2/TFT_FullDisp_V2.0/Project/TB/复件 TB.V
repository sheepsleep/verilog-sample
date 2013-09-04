module TFT_FullDisp(
input                     sys_clk  ,                //osc clock input
input                     sys_rst_n,                //系统复位输入

output  wire              LCD_SCL  ,                //LCD使能信号
output  reg               LCD_SDA  ,                //LCD的数据总线（不进行读操作，故为输出）
output  reg               LCD_RS   ,                // PSB, 1 is  8 bit data mode
output  reg               LCD_CS   ,                // PSB, 1 is  8 bit data mode
output  reg               LCD_RST        
);   
