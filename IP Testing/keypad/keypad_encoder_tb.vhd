-- Electronic door lock state machine
-- 4x4 keypad encoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use std.env.finish;
 
entity keypad_encoder_tb is
end keypad_encoder_tb;
 
architecture behave of keypad_encoder_tb is 
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal row_out : std_logic_vector(3 downto 0);
  signal col_in : std_logic_vector(3 downto 0);
  signal pressed : std_logic := '0';
  signal key : std_logic_vector(3 downto 0);

  -- Keypad stimulus
  signal key_stimulus : std_logic_vector(4 downto 0) := "00000";

begin
  keypad_encoder_inst: entity work.keypad_encoder
   port map(
      i_clk => clk,
      i_rst => rst,
      i_col => col_in,
      o_row => row_out,
      o_pressed => pressed,
      o_key => key
  );

  clk <= not clk after 1 ns;

  keypad_stimulus : process(row_out,key_stimulus)
    variable cols_var: std_logic_vector(3 downto 0) := "0000";
  begin
    if key_stimulus(4) = '1' then
      -- Put the right column value when a row is driven high
      if (2 ** to_integer(unsigned(key_stimulus(3 downto 2)))) = to_integer(unsigned(row_out)) then
        if key_stimulus(1 downto 0) = "11" then
          cols_var := "1000";
        elsif key_stimulus(1 downto 0) = "10" then
          cols_var := "0100";
        elsif key_stimulus(1 downto 0) = "01" then
          cols_var := "0010";
        elsif key_stimulus(1 downto 0) = "00" then
          cols_var := "0001";
        end if;
      else
        cols_var := "0000";
      end if;
    else
      cols_var := "0000";
    end if;
    col_in <= cols_var;
  end process;

  process
  begin
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    -- Loop through all keys
    for i in 0 to 15 loop
      key_stimulus <= '1' & std_logic_vector(to_unsigned(i,4));
      wait for 200 ns;
      key_stimulus <= "00000";
      wait for 20 ns;
    end loop;
    finish;
  end process;
end architecture behave;
