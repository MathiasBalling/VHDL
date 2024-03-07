library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity counter_tb is
end counter_tb;

architecture behave of counter_tb is
  signal rst : std_logic;
  signal clk : std_logic;

  signal sec : std_logic_vector(5 downto 0);
  signal min : std_logic_vector(5 downto 0);

  constant clk_freq : integer := 1;
  constant clk_period : time := 1 ns / clk_freq;
  signal stop_simulation : boolean := false;

begin
  clock : entity work.counter
    port map (
      i_clk => clk,
      i_rst => rst,
      o_sec_cnt => sec,
      o_min_cnt => min
      );

    -- Clock process
  clk_process : process begin
    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;
  end process;

  -- Reset process
  process is
  begin
    rst <= '0';
    wait for 60 * clk_period * 60;
    rst <= '1';
    wait for 100 ns;
    report "Reset activated";
    finish;
  end process;

end behave;
