-- Electronic door lock state machine
-- 4x4 keypad encoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use std.env.finish;
 
entity pad_mod_behave_tb is
end pad_mod_behave_tb;
 
architecture behave of pad_mod_behave_tb is 
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal row_out : std_logic_vector(3 downto 0);
  signal col_in : std_logic_vector(3 downto 0);
  signal led0 : std_logic;
  signal led1 : std_logic;
  -- Keypad stimulus
  signal key_stimulus : std_logic_vector(4 downto 0) := "00000";
begin
  controller_inst : entity work.controller
   port map(
      clk => clk,
      rst => rst,
      led0 => led0,
      led1 => led1,
      col_in => col_in,
      row_out => row_out
  );

  clk <= not clk after 1 ns;

  keypad_stimulus : process(row_out,key_stimulus)
    variable cols_var: std_logic_vector(3 downto 0) := "1111";
  begin
    if key_stimulus(4) = '1' then
      -- Put the right column value when a row is driven high
      if (2 ** to_integer(unsigned(key_stimulus(3 downto 2)))) = to_integer(unsigned(not row_out)) then
        if key_stimulus(1 downto 0) = "11" then
          cols_var := "0111";
        elsif key_stimulus(1 downto 0) = "10" then
          cols_var := "1011";
        elsif key_stimulus(1 downto 0) = "01" then
          cols_var := "1101";
        elsif key_stimulus(1 downto 0) = "00" then
          cols_var := "1110";
        end if;
      else
        cols_var := "1111";
      end if;
    else
      cols_var := "1111";
    end if;
    col_in <= cols_var;
  end process;

  process
  begin
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    key_stimulus <= "00000";
    wait for 10 ns;
    key_stimulus <= "10100";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 10 ns;
    key_stimulus <= "10101";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 10 ns;
    key_stimulus <= "10110";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 10 ns;
    key_stimulus <= "11000";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 10 ns;
    key_stimulus <= "10001";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 500 ns;
    key_stimulus <= "10011";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 500 ns;
    key_stimulus <= "11100";
    wait for 10 ns;
    key_stimulus <= "00000";
    wait for 500 ns;
    finish;
  end process;
end architecture behave;
