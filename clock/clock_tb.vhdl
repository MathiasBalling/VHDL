library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity clock_tb is
end clock_tb;

architecture behave of clock_tb is
  signal rst : std_logic;
  signal clk : std_logic;

  signal sec : std_logic_vector(5 downto 0);
  signal min : std_logic_vector(5 downto 0);

  constant clk_period : time := 1 ns;

begin
  clock : entity work.clock
    port map (
      i_clk => clk,
      i_rst => rst,
      o_sec_cnt => sec,
      o_min_cnt => min
      );

    -- Clock process
    process begin
      clk <= '0';
      wait for clk_period / 2;
      clk <= '1';
      wait for clk_period / 2;
    end process;

  process begin
    rst <= '0';
    -- 61 minutes simulation time
    wait for clk_period * 60 * 61;
    rst <= '1';
    wait for clk_period * 10;
    finish;
  end process;
end behave;
