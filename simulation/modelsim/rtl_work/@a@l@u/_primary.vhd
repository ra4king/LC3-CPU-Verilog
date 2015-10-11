library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        aluk            : in     vl_logic_vector(1 downto 0);
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end ALU;
