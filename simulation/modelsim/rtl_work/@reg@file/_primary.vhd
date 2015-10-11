library verilog;
use verilog.vl_types.all;
entity RegFile is
    generic(
        SEL_BITS        : vl_notype;
        BIT_SIZE        : vl_notype;
        TOTAL_REGS      : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        DR              : in     vl_logic_vector;
        data            : in     vl_logic_vector;
        we              : in     vl_logic;
        sel_SR1         : in     vl_logic_vector;
        sel_SR2         : in     vl_logic_vector;
        SR1             : out    vl_logic_vector;
        SR2             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SEL_BITS : constant is 5;
    attribute mti_svvh_generic_type of BIT_SIZE : constant is 5;
    attribute mti_svvh_generic_type of TOTAL_REGS : constant is 3;
end RegFile;
