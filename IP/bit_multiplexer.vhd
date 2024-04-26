library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity multiplexer is
    generic (
        n_sel_bits : natural := 8  -- Number of inputs
    );
    port (
        sel : in std_logic_vector(n_sel_bits-1 downto 0);  -- Select input
        din : in std_logic_vector(2**n_sel_bits-1 downto 0);  -- Data inputs
        dout : out std_logic  -- Data output
    );
end entity multiplexer;

architecture behave of multiplexer is
begin
    process(sel, din)
    begin
        dout <= din(to_integer(unsigned(sel)));
    end process;
end architecture behave;
