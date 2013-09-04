library verilog;
use verilog.vl_types.all;
entity divider4_5 is
    generic(
        WIDTH           : integer := 10;
        SIZE            : integer := 8
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        data_in         : in     vl_logic_vector;
        clkout          : out    vl_logic
    );
end divider4_5;
