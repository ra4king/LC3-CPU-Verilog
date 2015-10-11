library verilog;
use verilog.vl_types.all;
entity ConditionCode is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        ldCC            : in     vl_logic;
        \bus\           : in     vl_logic_vector(15 downto 0);
        CC              : out    vl_logic_vector(2 downto 0)
    );
end ConditionCode;
