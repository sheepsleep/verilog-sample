library verilog;
use verilog.vl_types.all;
entity system is
    generic(
        tDLY            : integer := 2;
        Programmed_Length: integer := 0;
        Single_Access   : integer := 1;
        Standard        : integer := 0;
        Latency_2       : integer := 2;
        Latency_3       : integer := 3;
        Sequential      : integer := 0;
        Interleaved     : integer := 1;
        Length_1        : integer := 0;
        Length_2        : integer := 1;
        Length_4        : integer := 2;
        Length_8        : integer := 3;
        RA_MSB          : integer := 22;
        RA_LSB          : integer := 11;
        BA_MSB          : integer := 10;
        BA_LSB          : integer := 9;
        CA_MSB          : integer := 8;
        CA_LSB          : integer := 0;
        SDR_BA_WIDTH    : integer := 2;
        SDR_A_WIDTH     : integer := 12;
        tCK             : integer := 12;
        tRP             : integer := 15;
        tRFC            : integer := 66;
        tRCD            : integer := 15;
        i_NOP           : integer := 0;
        i_PRE           : integer := 1;
        i_tRP           : integer := 2;
        i_AR1           : integer := 3;
        i_tRFC1         : integer := 4;
        i_AR2           : integer := 5;
        i_tRFC2         : integer := 6;
        i_MRS           : integer := 7;
        i_tMRD          : integer := 8;
        i_ready         : integer := 9;
        c_idle          : integer := 0;
        c_tRCD          : integer := 1;
        c_cl            : integer := 2;
        c_rdata         : integer := 3;
        c_wdata         : integer := 4;
        c_tRFC          : integer := 5;
        c_tDAL          : integer := 6;
        c_ACTIVE        : integer := 8;
        c_READA         : integer := 9;
        c_WRITEA        : integer := 10;
        c_AR            : integer := 11;
        INHIBIT         : integer := 15;
        NOP             : integer := 7;
        ACTIVE          : integer := 3;
        READ            : integer := 5;
        WRITE           : integer := 4;
        BURST_TERMINATE : integer := 6;
        PRECHARGE       : integer := 2;
        AUTO_REFRESH    : integer := 1;
        LOAD_MODE_REGISTER: integer := 0;
        clock_time      : integer := 100;
        reset_time      : integer := 1000
    );
    port(
        sys_CLK         : out    vl_logic;
        sys_RESET       : out    vl_logic;
        sys_A           : out    vl_logic_vector(23 downto 1);
        sys_ADSn        : out    vl_logic;
        sys_R_Wn        : out    vl_logic;
        sys_D           : out    vl_logic_vector(15 downto 0);
        sys_DLY_100US   : out    vl_logic;
        sys_REF_REQ     : out    vl_logic;
        sys_CYC_END     : in     vl_logic;
        sys_INIT_DONE   : in     vl_logic
    );
end system;
