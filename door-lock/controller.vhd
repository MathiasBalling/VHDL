library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
  port(
    clk : in std_logic;
    led0 : out std_logic
    -- TODO: Ports for keypad
  );
end entity;

architecture rtl of controller is
  -- PWM
  signal pwm : std_logic;
  signal pwm_rst : std_logic := '1';
  signal duty_cycle : std_logic_vector(7 downto 0) := (others => '0');

  -- EDL controller
  signal edl_rst : std_logic := '0';
  signal edl_busy : std_logic := '0';
  signal edl_unlocked : std_logic := '0';

  -- Debouncer
  signal db_intr : std_logic := '1';

  -- Keypad
  signal kp_key : std_logic_vector(3 downto 0);
begin
  pwm_inst : entity work.pwm
    port map(
      clk => clk,
      rst => pwm_rst,
      duty_cycle => duty_cycle,
      pwm_out => pwm);
  led0 <= pwm;

  edl_controller_inst : entity work.edl_controller
    port map(
      clk => clk,
      rst => edl_rst,
      intr => db_intr,
      key => kp_key,
      busy => edl_busy,
      unlocked => edl_unlocked);

  debouncer_inst : entity work.debouncer
  port map(
    clk => clk,
    rst => pwm_rst,
    inpt => kp_key,
    outp => db_intr);

end rtl;
