library verilog;
use verilog.vl_types.all;
entity cyclone_and16 is
    port(
        y               : out    vl_logic_vector(15 downto 0);
        in1             : in     vl_logic_vector(15 downto 0)
    );
end cyclone_and16;
