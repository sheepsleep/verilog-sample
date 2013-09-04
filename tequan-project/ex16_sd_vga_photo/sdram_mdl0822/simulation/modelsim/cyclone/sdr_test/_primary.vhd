library verilog;
use verilog.vl_types.all;
entity sdr_test is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sdram_clk       : out    vl_logic;
        sdram_cke       : out    vl_logic;
        sdram_cs_n      : out    vl_logic;
        sdram_ras_n     : out    vl_logic;
        sdram_cas_n     : out    vl_logic;
        sdram_we_n      : out    vl_logic;
        sdram_ba        : out    vl_logic_vector(1 downto 0);
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_data      : inout  vl_logic_vector(15 downto 0);
        spi_miso        : in     vl_logic;
        spi_mosi        : out    vl_logic;
        spi_clk         : out    vl_logic;
        spi_cs_n        : out    vl_logic;
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        vga_r           : out    vl_logic_vector(1 downto 0);
        vga_g           : out    vl_logic_vector(2 downto 0);
        vga_b           : out    vl_logic_vector(2 downto 0)
    );
end sdr_test;
