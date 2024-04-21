-- 4x4 keypad encoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;
 
entity keypad_encoder is
  port (
    -- Clock and reset
    clk, rst : in std_logic;

    -- Interfacing with the keypad
    col_in : in std_logic_vector(3 downto 0);
    row_out : out std_logic_vector(3 downto 0);

    -- Output to the user
    pressed : out std_logic;
    key : out std_logic_vector(3 downto 0)
  );
end keypad_encoder;
 
architecture behave of keypad_encoder is 
  type state_type is (s_rst, scan, press);
  signal current_state, next_state : state_type := scan;
  signal col : integer range 0 to 3;
  signal row : integer range 0 to 3;
  signal activated_row : std_logic_vector(3 downto 0);
begin
  clocked_process : process(clk, rst)
    begin
      if rst = '1' then
        current_state <= s_rst;
        row_out <= (others => '0');
      elsif rising_edge(clk) then
        current_state <= next_state;
        case next_state is
          when scan =>
            if row = 3 then row <= 0;
            else row <= row + 1;
            end if;
            row_out <= std_logic_vector(to_unsigned(2**row, 4));
          when others =>
            row_out <= activated_row;
            -- Make sure that activated_row is a power of 2
            case activated_row is
              when "0001" => row <= 0;
              when "0010" => row <= 1;
              when "0100" => row <= 2;
              when "1000" => row <= 3;
              when others => null;
            end case;
      end case;
    end if;
  end process;


  next_state_logic : process(current_state, col_in)
    begin
      case current_state is
      when s_rst =>
        next_state <= scan;
        activated_row <= (others => '0');

      when scan =>
        if col_in /= "1111" then
          -- Row is found
          activated_row <= row_out;
          -- Find the column
          if    col_in(0) = '0' then col <= 0;
          elsif col_in(1) = '0' then col <= 1;
          elsif col_in(2) = '0' then col <= 2;
          elsif col_in(3) = '0' then col <= 3;
          end if;
          next_state <= press;
        end if;

      when press =>
        -- wait for key release
        if col_in = "1111" then next_state <= scan;
        end if;
      when others => null;
      end case;
    end process;


  current_state_logic : process(current_state)
    begin
      case current_state is
        when scan =>
          pressed <= '0';
          key <= (others => '0');
        when press =>
          pressed <= '1';
          key <= std_logic_vector(to_unsigned(row * 4 + col, 4));
        when others => null;
      end case;
    end process;
end architecture behave;
