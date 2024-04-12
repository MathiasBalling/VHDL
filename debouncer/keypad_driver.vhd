library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity keypad_driver is
  port(
    key_pressed : in std_logic_vector(3 downto 0);
    rows : in std_logic_vector(3 downto 0);
    cols : out std_logic_vector(3 downto 0)
  );
end keypad_driver;

architecture behave of keypad_driver is
  signal cols_var : std_logic_vector(3 downto 0);
begin
  process(key_pressed, rows)
  begin
    if key_pressed = "0000" then
      cols_var <= "1111";
    else
      case rows is
      when "1110" =>
        cols_var <= "1110";
      when "1101" =>
        cols_var <= "1101";
      when "1011" =>
        cols_var <= "1011";
      when "0111" =>
        cols_var <= "0111";
      when others =>
        cols_var <= "1111";
      end case;
    end if;
      end process;
end behave;
