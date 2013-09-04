library verilog;
use verilog.vl_types.all;
entity sdram is
    generic(
        pwrup_time      : integer := 200000;
        pwrup_check     : integer := 0
    );
    port(
        clk             : in     vl_logic;
        csb             : in     vl_logic;
        cke             : in     vl_logic;
        ba              : in     vl_logic_vector(1 downto 0);
        ad              : in     vl_logic_vector(11 downto 0);
        rasb            : in     vl_logic;
        casb            : in     vl_logic;
        web             : in     vl_logic;
        dqm             : in     vl_logic_vector(1 downto 0);
        dqi             : inout  vl_logic_vector(15 downto 0)
    );
end sdram;
