library verilog;
use verilog.vl_types.all;
entity SRAM_TEST is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        SRAM_DQ         : inout  vl_logic_vector(15 downto 0);
        SRAM_ADDR       : out    vl_logic_vector(17 downto 0);
        SRAM_CE         : out    vl_logic;
        SRAM_OE         : out    vl_logic;
        SRAM_WE         : out    vl_logic;
        SRAM_UB         : out    vl_logic;
        SRAM_LB         : out    vl_logic;
        LED             : out    vl_logic_vector(7 downto 0)
    );
end SRAM_TEST;
