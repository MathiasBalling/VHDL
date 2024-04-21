library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
  port (clk : in std_logic;
        reset : in std_logic;
        duty_cycle : in std_logic_vector(7 downto 0);
        pwm_out : out std_logic);
end pwm;

architecture behavioral of pwm is
    signal counter : unsigned(7 downto 0) := (others => '0');
    signal pwm_value : unsigned(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            pwm_out <= '0';
        elsif rising_edge(clk) then
            if counter = 200 then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;

            pwm_value <= unsigned(duty_cycle);
            if counter < pwm_value then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end behavioral;
