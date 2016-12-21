library verilog;
use verilog.vl_types.all;
entity calculateScaleStep is
    port(
        rows            : in     vl_logic_vector(11 downto 0);
        cols            : in     vl_logic_vector(11 downto 0);
        step            : out    vl_logic_vector(4 downto 0)
    );
end calculateScaleStep;
