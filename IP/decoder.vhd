library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_decoder is
  generic (
    n_sel_bits : natural := 8  -- number of input bits (default: 8)
  );
  port (
    data : in std_logic_vector(n_sel_bits-1 downto 0);
    output : out std_logic_vector(2**n_sel_bits-1 downto 0)
  );
end nbit_decoder;

architecture behavioral of nbit_decoder is
begin
process(data)
  begin
    output <= (others => '0');
    output(to_integer(unsigned(data))) <= '1';
end process;

end behavioral;
