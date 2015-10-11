library verilog;
use verilog.vl_types.all;
entity Microcontroller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        IR              : in     vl_logic_vector(15 downto 0);
        CC              : in     vl_logic_vector(2 downto 0);
        ALUK            : out    vl_logic_vector(1 downto 0);
        sel_PCMUX       : out    vl_logic_vector(1 downto 0);
        sel_ADDR2MUX    : out    vl_logic_vector(1 downto 0);
        sel_ADDR1MUX    : out    vl_logic;
        sel_MARMUX      : out    vl_logic;
        ldPC            : out    vl_logic;
        ldIR            : out    vl_logic;
        ldCC            : out    vl_logic;
        ldREG           : out    vl_logic;
        ldMAR           : out    vl_logic;
        ldMDR           : out    vl_logic;
        drPC            : out    vl_logic;
        drALU           : out    vl_logic;
        drMARMUX        : out    vl_logic;
        drMDR           : out    vl_logic;
        MEM_W           : out    vl_logic;
        MEM_EN          : out    vl_logic;
        state           : out    vl_logic_vector(5 downto 0);
        signals_out     : out    vl_logic_vector(27 downto 0)
    );
end Microcontroller;
