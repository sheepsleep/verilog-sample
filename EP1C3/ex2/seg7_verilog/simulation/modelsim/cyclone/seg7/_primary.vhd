library verilog;
use verilog.vl_types.all;
entity seg7 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ds_stcp         : out    vl_logic;
        ds_shcp         : out    vl_logic;
        ds_data         : out    vl_logic
    );
end seg7;
