library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic (
    n_bits : natural := 8
  );
  port (
    i_enable : in std_logic;
    i_clk : in std_logic;
    i_reset : in std_logic;

    o_cnt : out std_logic_vector(n_bits-1 downto 0)
  );
end counter;

architecture structure of counter is
  signal cnt : unsigned(n_bits-1 downto 0) := (others => '0');
begin
  process(i_clk,i_reset)
  begin
    if i_reset = '1' then
      cnt <= (others => '0');
    elsif rising_edge(i_clk) then
      if i_enable = '1' then
        cnt <= cnt + "1";
      end if;
    end if;
    o_cnt <= std_logic_vector(cnt);
  end process;
end structure;
