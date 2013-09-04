library verilog;
use verilog.vl_types.all;
entity TFT_FullDisp is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LCD_SCL         : out    vl_logic;
        LCD_SDA         : out    vl_logic;
        LCD_RS          : out    vl_logic;
        LCD_CS          : out    vl_logic;
        LCD_RST         : out    vl_logic
    );
end TFT_FullDisp;
