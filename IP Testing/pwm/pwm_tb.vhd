library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;
 
entity pwm_tb is
end pwm_tb;
 
architecture behave of pwm_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal duty_cycle : std_logic_vector(7 downto 0) := "00000000";
  signal pwm_out : std_logic := '0';
begin
  pwm_inst : entity work.pwm
    port map(
      clk => clk,
      rst => rst,
      duty_cycle => duty_cycle,
      pwm_out => pwm_out
    );
  clk <= not clk after 1 ns;

  process
  begin
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    duty_cycle <= std_logic_vector(to_unsigned(0, 8));
    wait for 1000 ns;
    duty_cycle <= std_logic_vector(to_unsigned(100, 8));
    wait for 1000 ns;
    duty_cycle <= std_logic_vector(to_unsigned(20, 8));
    wait for 1000 ns;
    finish;
  end process;

end behave;
