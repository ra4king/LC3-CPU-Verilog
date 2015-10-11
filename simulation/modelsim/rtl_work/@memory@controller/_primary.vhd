library verilog;
use verilog.vl_types.all;
entity MemoryController is
    generic(
        ADDRESS_BITS    : vl_notype;
        MEMORY_BITS     : vl_notype;
        TOTAL_ADDRESSES : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        addr            : in     vl_logic_vector;
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector;
        we              : in     vl_logic;
        \select\        : in     vl_logic;
        SW              : in     vl_logic_vector(9 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        LEDG            : out    vl_logic_vector(7 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESS_BITS : constant is 5;
    attribute mti_svvh_generic_type of MEMORY_BITS : constant is 5;
    attribute mti_svvh_generic_type of TOTAL_ADDRESSES : constant is 3;
end MemoryController;
