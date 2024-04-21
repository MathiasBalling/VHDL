library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;
 
entity full_adder_tb is
end full_adder_tb;
 
architecture behave of full_adder_tb is
  signal i_A, i_B, i_C : std_logic;
  signal o_S, o_C : std_logic;
begin
  adder : entity work.full_adder
    port map (
      i_A => i_A,
      i_B => i_B,
      i_C => i_C,
      o_S => o_S,
      o_C => o_C
    );

  process is
  begin
    i_A <= '0'; i_B <= '0'; i_C <= '0'; wait for 10 ns;
    i_A <= '0'; i_B <= '0'; i_C <= '1'; wait for 10 ns;
    i_A <= '0'; i_B <= '1'; i_C <= '0'; wait for 10 ns;
    i_A <= '0'; i_B <= '1'; i_C <= '1'; wait for 10 ns;
    i_A <= '1'; i_B <= '0'; i_C <= '0'; wait for 10 ns;
    i_A <= '1'; i_B <= '0'; i_C <= '1'; wait for 10 ns;
    i_A <= '1'; i_B <= '1'; i_C <= '0'; wait for 10 ns;
    i_A <= '1'; i_B <= '1'; i_C <= '1'; wait for 10 ns;
    wait for 10 ns;

    finish;
  end process;
end behave;
