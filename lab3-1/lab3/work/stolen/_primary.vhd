library verilog;
use verilog.vl_types.all;
entity stolen is
    port(
        steal           : out    vl_logic;
        U               : in     vl_logic;
        P               : in     vl_logic;
        C               : in     vl_logic;
        M               : in     vl_logic
    );
end stolen;
