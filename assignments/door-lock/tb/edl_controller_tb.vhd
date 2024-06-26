-- Electronic door lock state machine
-- Unlock Code: 4567
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;
 
entity edl_controller_tb is
end edl_controller_tb;
 
architecture behave of edl_controller_tb is 
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal intr : std_logic := '0';
  signal key : std_logic_vector(3 downto 0);

  signal duty_cycle : std_logic_vector(7 downto 0);
  signal busy : std_logic;
  signal unlock : std_logic;
begin
  edl_controller_inst: entity work.edl_controller
   port map(
      i_clk => clk,
      i_rst => rst,
      i_intr => intr,
      i_key => key,
      o_duty_cycle => duty_cycle,
      o_busy => busy,
      o_unlocked => unlock
  );

  clk <= not clk after 1 ns;

  edt_stimulus: process
  begin
    wait for 5 ns;
    key <= "0000";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "0100";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "0101";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "0110";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "0111";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "1000";
    intr <= '1';
    wait for 1 ns;
    intr <= '0';
    wait for 5 ns;
    key <= "0011";
    intr <= '1';
    wait for 50 ns;
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    wait for 50 ns;
    finish;
  end process;


end architecture behave;
