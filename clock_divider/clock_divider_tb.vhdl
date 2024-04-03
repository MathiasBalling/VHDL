library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;
 
entity clock_divider_tb is
end clock_divider_tb;
 
architecture behave of clock_divider_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal clk_div : std_logic;

  constant clk_period : time := 1 ns;
  constant clk_div_n : integer := 4;
  component clock_divider 
    generic (
      n_bits : integer
    );
    port(
      i_clk  : in std_logic;
      i_rst : in std_logic;

      o_clk_div : out std_logic
    );
  end component;
begin
  clock_divider_inst : clock_divider
    generic map(
      n_bits => clk_div_n
    )
    port map(
    i_clk => clk,
    i_rst => rst,
    o_clk_div => clk_div
    );

  -- Clock process
  clk <= not clk after clk_period/2;

  process is
  begin
    wait for 1000 ns;
    finish;
  end process;
end behave;
