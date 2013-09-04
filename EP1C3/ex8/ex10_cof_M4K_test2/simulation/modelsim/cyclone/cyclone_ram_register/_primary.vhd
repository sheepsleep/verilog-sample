library verilog;
use verilog.vl_types.all;
entity cyclone_ram_register is
    generic(
        width           : integer := 1;
        preset          : integer := 0
    );
    port(
        d               : in     vl_logic_vector;
        clk             : in     vl_logic;
        aclr            : in     vl_logic;
        devclrn         : in     vl_logic;
        devpor          : in     vl_logic;
        ena             : in     vl_logic;
        q               : out    vl_logic_vector;
        aclrout         : out    vl_logic
    );
end cyclone_ram_register;
