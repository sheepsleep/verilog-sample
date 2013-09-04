library verilog;
use verilog.vl_types.all;
entity FLASH_TEST is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        FLASH_DQ        : inout  vl_logic_vector(15 downto 0);
        FLASH_ADDR      : out    vl_logic_vector(20 downto 0);
        FLASH_CE        : out    vl_logic;
        FLASH_OE        : out    vl_logic;
        FLASH_WE        : out    vl_logic;
        FLASH_RST       : out    vl_logic;
        LED             : out    vl_logic_vector(7 downto 0)
    );
end FLASH_TEST;
