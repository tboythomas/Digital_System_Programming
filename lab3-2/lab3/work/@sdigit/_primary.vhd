library verilog;
use verilog.vl_types.all;
entity Sdigit is
    port(
        Output2         : out    vl_logic;
        SW4             : in     vl_logic;
        SW5             : in     vl_logic;
        SW6             : in     vl_logic;
        SW7             : in     vl_logic
    );
end Sdigit;
