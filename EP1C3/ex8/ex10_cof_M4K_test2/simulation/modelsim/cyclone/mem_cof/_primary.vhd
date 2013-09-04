library verilog;
use verilog.vl_types.all;
entity mem_cof is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        shift_din       : in     vl_logic_vector(3 downto 0);
        shift_dout      : out    vl_logic_vector(3 downto 0);
        taps0x          : out    vl_logic_vector(3 downto 0);
        taps1x          : out    vl_logic_vector(3 downto 0);
        taps2x          : out    vl_logic_vector(3 downto 0);
        taps3x          : out    vl_logic_vector(3 downto 0);
        taps4x          : out    vl_logic_vector(3 downto 0);
        taps5x          : out    vl_logic_vector(3 downto 0);
        taps6x          : out    vl_logic_vector(3 downto 0);
        taps7x          : out    vl_logic_vector(3 downto 0)
    );
end mem_cof;
