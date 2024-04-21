library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity d_latch_tb is
end d_latch_tb;
 
architecture behave of d_latch_tb is
  signal d : std_logic;
  signal en : std_logic;

  signal q : std_logic;
  signal qn : std_logic;
begin
  UUT : entity work.d_latch
    port map (
      i_data => d,
      i_enable => en,
      o_q => q,
      o_qn => qn
    );
  process is
  begin
    wait for 10 ns;
    d <= '0';
    en <= '0';
    wait for 10 ns;
    d <= '1';
    en <= '1';
    wait for 10 ns;
    d <= '0';
    en <= '1';
    wait for 10 ns;
    d <= '1';
    en <= '0';
    wait for 10 ns;
    assert false report "End of test" severity note;
    wait;
  end process;
end behave;
