-- 4x4 keypad encoder
-- 0 -> 0 
-- 1 -> 1 
-- ...
-- 9 -> 9
-- A -> 10
-- B -> 11
-- C -> 12
-- D -> 13
-- * -> 14
-- # -> 15
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

-- Pull-up on i_col
-- Col_in is low when activated
-- Row_out should be driven low when scaning
 
entity keypad_encoder is
  port (
    -- Clock and reset
  i_clk, i_rst : in std_logic;

    -- Interfacing with the keypad
  i_col : in std_logic_vector(3 downto 0);
  o_row : out std_logic_vector(3 downto 0);

    -- Output to the user
  o_pressed : out std_logic;
  o_key : out std_logic_vector(3 downto 0)
);
end keypad_encoder;
 
architecture behave of keypad_encoder is 
  type state_type is (s_rst, scan, press);
  signal current_state, next_state : state_type := scan;
  signal col : integer range 0 to 3;
  signal row : integer range 0 to 3;
  signal activated_row : std_logic_vector(3 downto 0);
begin
  clocked_process : process(i_clk, i_rst)
    begin
      if i_rst = '1' then
        current_state <= s_rst;
        o_row <= (others => '1');
      elsif rising_edge(i_clk) then
        current_state <= next_state;
        case next_state is
          when scan =>
            if row = 3 then row <= 0;
            else row <= row + 1;
            end if;
            o_row <= not std_logic_vector(to_unsigned(2**row, 4));
          when others =>
            o_row <= activated_row;
            case activated_row is
              when "1110" => row <= 0;
              when "1101" => row <= 1;
              when "1011" => row <= 2;
              when "0111" => row <= 3;
              when others => null;
            end case;
      end case;
    end if;
  end process;


  next_state_logic : process(current_state, i_col)
    begin
      case current_state is
      when s_rst =>
        next_state <= scan;
        activated_row <= (others => '1');
      when scan =>
        if i_col /= "1111" then
          -- Row is found
          activated_row <= o_row;
          -- Find the column
          if    i_col(0) = '0' then col <= 0;
          elsif i_col(1) = '0' then col <= 1;
          elsif i_col(2) = '0' then col <= 2;
          elsif i_col(3) = '0' then col <= 3;
          end if;
          next_state <= press;
        end if;
      when press =>
        -- wait for o_key release
        if i_col = "1111" then next_state <= scan;
        end if;
      when others => null;
      end case;
    end process;


  current_state_logic : process(current_state)
    begin
      case current_state is
        when scan =>
          o_pressed <= '0';
          o_key <= (others => '0');
        when press =>
          o_pressed <= '1';
          -- Look up table
          case std_logic_vector(to_unsigned(row * 4 + col, 4)) is
            when "0000" => o_key <= "0001"; -- 1
            when "0001" => o_key <= "0010"; -- 2
            when "0010" => o_key <= "0011"; -- 3
            when "0011" => o_key <= "1010"; -- A
            when "0100" => o_key <= "0100"; -- 4
            when "0101" => o_key <= "0101"; -- 5
            when "0110" => o_key <= "0110"; -- 6
            when "0111" => o_key <= "1011"; -- B
            when "1000" => o_key <= "0111"; -- 7
            when "1001" => o_key <= "1000"; -- 8
            when "1010" => o_key <= "1001"; -- 9
            when "1011" => o_key <= "1100"; -- C
            when "1100" => o_key <= "1110"; -- *
            when "1101" => o_key <= "0000"; -- 0
            when "1110" => o_key <= "1111"; -- #
            when "1111" => o_key <= "1101"; -- D
            when others => null;
            end case;
        when others => null;
      end case;
    end process;
end architecture behave;
