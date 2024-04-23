library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
  port( clk : in std_logic;
        rst : in std_logic;
        -- For locked/unlocked state
        led0 : out std_logic;
        -- Inverted output of led0
        led1 : out std_logic;
        -- For PWM
        led2 : out std_logic;
        -- For keypad
        col : in std_logic_vector(3 downto 0);
        row : out std_logic_vector(3 downto 0)
      );
end entity;
-- Overview:
-- Clock divider to generate <10KHz clock
-- Keypad encoder
-- Debouncer for keypad (only 1 key press at a time)
-- EDL controller with status led0 (locked/unlocked)
-- PWM for LED1 (depends on keypad input in unlocked state)

architecture rtl of controller is
  signal clk_div : std_logic;

  -- EDL controller
  signal edl_busy : std_logic;
  signal edl_duty_cycle : std_logic_vector(7 downto 0);
  signal edl_unlocked : std_logic;

  -- Debouncer
  signal db_intr : std_logic;

  -- Keypad
  signal kp_key : std_logic_vector(3 downto 0);
  signal kp_pressed : std_logic;

  -- pwm
  signal pwm : std_logic;
begin
  --clock_divider_inst : entity work.clock_divider
  --generic map( n_bits => 14)
  --port map( i_clk => clk,
    --        i_rst => rst,
      --      o_clk_div => clk_div);
  clk_div <= clk;

  keypad_encoder_inst : entity work.keypad_encoder
  port map( i_clk => clk_div,
            i_rst => rst,
            i_col => col,
            o_row => row,
            o_pressed => kp_pressed,
            o_key => kp_key);

  debouncer_inst : entity work.debouncer
  port map( clk => clk_div,
            rst => rst,
            inp => kp_pressed,
            outp => db_intr);

  edl_controller_inst : entity work.edl_controller
  port map( i_clk => clk_div,
            i_rst => rst,
            i_intr => db_intr,
            i_key => kp_key,
            o_duty_cycle => edl_duty_cycle,
            o_busy => edl_busy,
            o_unlocked => edl_unlocked);
  -- Status LED
  led0 <= edl_unlocked;
  led1 <= not edl_unlocked;

  pwm_inst : entity work.pwm
  port map( clk => clk_div,
            rst => rst,
            duty_cycle => edl_duty_cycle,
            pwm_out => pwm);
  -- PWM output
  led2 <= pwm;
end rtl;

