library verilog;
use verilog.vl_types.all;
entity SEXT is
    generic(
        BIT_SIZE_IN     : vl_notype;
        BIT_SIZE_OUT    : vl_notype
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_SIZE_IN : constant is 5;
    attribute mti_svvh_generic_type of BIT_SIZE_OUT : constant is 5;
end SEXT;
