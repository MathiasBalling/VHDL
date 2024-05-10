library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
  generic ( period : integer := 100);
  port ( clk : in std_logic;
         rst : in std_logic;
         duty_cycle : in std_logic_vector(7 downto 0);
         pwm_out : out std_logic
       );
end pwm;

architecture behavioral of pwm is
  signal counter : unsigned(7 downto 0) := (others => '0');
  signal pwm : std_logic := '0';
begin

  process(clk, rst)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        counter <= (others => '0');
        pwm <= '0';
      else
        -- Counting up to period for fixed PWM frequency
        if counter = period - 1 then
          counter <= (others => '0');
        else
          counter <= counter + 1;
        end if;

        -- Duty cycle control
        if counter < unsigned(duty_cycle) then
          pwm <= '1';
        else
          pwm <= '0';
        end if;
      end if;
    end if;
  end process;

  pwm_out <= pwm;
end behavioral;
