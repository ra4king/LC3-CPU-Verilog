library verilog;
use verilog.vl_types.all;
entity LC3_CPU is
    port(
        CLOCK_50        : in     vl_logic;
        SW              : in     vl_logic_vector(9 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        LEDG            : out    vl_logic_vector(7 downto 0);
        PC_out          : out    vl_logic_vector(15 downto 0);
        IR_out          : out    vl_logic_vector(15 downto 0);
        sel_PCMUX_out   : out    vl_logic_vector(1 downto 0);
        ADDER_out       : out    vl_logic_vector(15 downto 0);
        CC_out          : out    vl_logic_vector(2 downto 0);
        MAR_out         : out    vl_logic_vector(15 downto 0);
        MEMORY_out      : out    vl_logic_vector(15 downto 0);
        MDR_out         : out    vl_logic_vector(15 downto 0);
        MEM_EN_out      : out    vl_logic;
        MEM_W_out       : out    vl_logic;
        BUS_out         : out    vl_logic_vector(15 downto 0);
        STATE_out       : out    vl_logic_vector(5 downto 0);
        SIGNALS_out     : out    vl_logic_vector(27 downto 0)
    );
end LC3_CPU;
