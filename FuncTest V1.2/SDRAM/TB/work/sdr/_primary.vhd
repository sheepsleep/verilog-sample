library verilog;
use verilog.vl_types.all;
entity sdr is
    generic(
        Num_Meg         : integer := 8;
        Data_Width      : integer := 4;
        Num_Bank        : integer := 4;
        tAC             : real    := 5.400000;
        tOH             : real    := 2.700000;
        SDR_A_WIDTH     : integer := 12;
        SDR_BA_WIDTH    : integer := 2;
        MEG             : integer := 1048576;
        ROW_WIDTH       : integer := 12
    );
    port(
        sdr_DQ          : inout  vl_logic_vector;
        sdr_A           : in     vl_logic_vector;
        sdr_BA          : in     vl_logic_vector;
        sdr_CK          : in     vl_logic;
        sdr_CKE         : in     vl_logic;
        sdr_CSn         : in     vl_logic;
        sdr_RASn        : in     vl_logic;
        sdr_CASn        : in     vl_logic;
        sdr_WEn         : in     vl_logic;
        sdr_DQM         : in     vl_logic
    );
end sdr;
