library verilog;
use verilog.vl_types.all;
entity SegLed is
    generic(
        width           : integer := 20;
        width2          : integer := 7
    );
    port(
        osc_clk         : in     vl_logic;
        sys_rst         : in     vl_logic;
        seg_mosi        : out    vl_logic;
        seg_ncs         : out    vl_logic;
        seg_sck         : out    vl_logic;
        seg_c1          : out    vl_logic;
        seg_c2          : out    vl_logic;
        seg_c3          : out    vl_logic;
        seg_c4          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of width2 : constant is 1;
end SegLed;
