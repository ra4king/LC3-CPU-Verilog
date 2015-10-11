library verilog;
use verilog.vl_types.all;
entity \Register\ is
    generic(
        BIT_SIZE        : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        we              : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_SIZE : constant is 5;
end \Register\;
