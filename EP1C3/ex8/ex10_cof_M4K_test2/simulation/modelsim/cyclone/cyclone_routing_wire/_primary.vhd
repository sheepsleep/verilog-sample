library verilog;
use verilog.vl_types.all;
entity cyclone_routing_wire is
    port(
        datain          : in     vl_logic;
        dataout         : out    vl_logic
    );
end cyclone_routing_wire;
