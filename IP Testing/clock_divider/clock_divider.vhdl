library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity clock_divider is
  generic (
    n_bits : integer
  );
  port (
    i_clk  : in std_logic;
    i_rst : in std_logic;

    o_clk_div : out std_logic := '0'
  );
end clock_divider;
 
architecture structure of clock_divider is
  signal cnt : unsigned(n_bits - 1 downto 0) := (others => '0');
begin
  process(i_clk, i_rst)
  begin
    if i_rst = '1' then
      cnt <= (others => '0');
      o_clk_div <= i_clk;
    elsif rising_edge(i_clk) then
      if cnt = 0 then
        cnt <= to_unsigned(2**n_bits - 1, n_bits);
        o_clk_div <= not o_clk_div;
      else
        cnt <= cnt - 1;
      end if;
    end if;
  end process;
end structure;
