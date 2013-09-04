library verilog;
use verilog.vl_types.all;
entity sys_ctrl_task is
    generic(
        period          : integer := 40;
        rst_ing         : integer := 0
    );
    port(
        clk             : out    vl_logic;
        rst_n           : out    vl_logic
    );
end sys_ctrl_task;
