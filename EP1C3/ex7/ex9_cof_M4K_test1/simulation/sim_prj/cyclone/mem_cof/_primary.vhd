library verilog;
use verilog.vl_types.all;
entity mem_cof is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ram_wr          : in     vl_logic;
        ram_addr        : in     vl_logic_vector(11 downto 0);
        ram_din         : in     vl_logic_vector(7 downto 0);
        ram_dout        : out    vl_logic_vector(7 downto 0)
    );
end mem_cof;
