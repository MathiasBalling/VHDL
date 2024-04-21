library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity nbit_multiplexer is
    generic (
        N : natural := 8  -- Number of inputs
    );
    port (
        sel : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);  -- Select input
        din : in std_logic_vector(N-1 downto 0);  -- Data inputs
        dout : out std_logic  -- Data output
    );
end entity nbit_multiplexer;

architecture behave of nbit_multiplexer is
begin
    process(sel, din)
    begin
        dout <= din(to_integer(unsigned(sel)));
    end process;
end architecture behave;
