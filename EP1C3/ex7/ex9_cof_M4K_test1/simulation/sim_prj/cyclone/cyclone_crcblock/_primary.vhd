library verilog;
use verilog.vl_types.all;
entity cyclone_crcblock is
    generic(
        oscillator_divider: integer := 1;
        lpm_type        : string  := "cyclone_crcblock"
    );
    port(
        clk             : in     vl_logic;
        shiftnld        : in     vl_logic;
        ldsrc           : in     vl_logic;
        crcerror        : out    vl_logic;
        regout          : out    vl_logic
    );
end cyclone_crcblock;
