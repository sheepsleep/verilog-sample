library verilog;
use verilog.vl_types.all;
entity PWM is
    port(
        sys_clk         : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        led             : out    vl_logic;
        moto_a          : out    vl_logic;
        moto_b          : out    vl_logic
    );
end PWM;
