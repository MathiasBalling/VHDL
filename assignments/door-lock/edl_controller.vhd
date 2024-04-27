-- MBC: Electronic door lock state machine
-- Unlock Code: 4567
-- Keycodes:
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

entity edl_controller is
  generic (
  -- Passcode
  nr1 : unsigned(3 downto 0) := "0100";
  nr2 : unsigned(3 downto 0) := "0101";
  nr3 : unsigned(3 downto 0) := "0110";
  nr4 : unsigned(3 downto 0) := "0111");

  port (
  i_clk, i_rst, i_intr : in std_logic;
  i_key : in std_logic_vector(3 downto 0);
  o_duty_cycle : out std_logic_vector(7 downto 0);
  o_busy, o_unlocked : out std_logic);
end edl_controller;

architecture behave of edl_controller is 
  type state_type is (s_rst,s0,s1,s2,s3,s4);
  signal current_state, next_state : state_type := s_rst;
  signal duty_cycle : unsigned(7 downto 0);
begin
  clocked_process : process(i_clk, i_rst)
  begin
    if i_rst = '1' then
      current_state <= s_rst;
    elsif rising_edge(i_clk) then
      current_state <= next_state;
    end if;
  end process;

  o_duty_cycle <= (others => '0') when current_state /= s4 else std_logic_vector(duty_cycle);

  next_state_logic : process(current_state,i_intr)
  begin
    if rising_edge(i_intr) then 
      case current_state is
        when s_rst =>
          next_state <= s0;
        when s0 =>
          if unsigned(i_key) = nr1 then next_state <= s1;
          else next_state <= s0;
          end if;
        when s1 =>
          if unsigned(i_key) = nr2 then next_state <= s2;
          else next_state <= s0;
          end if;
        when s2 =>
          if unsigned(i_key) = nr3 then next_state <= s3;
          else next_state <= s0;
          end if;
        when s3 =>
          if unsigned(i_key) = nr4 then next_state <= s4;
          else next_state <= s0;
          end if;
        when s4 =>
            -- Unlocked state wait for * key to lock
          case i_key is
            when "1110" => -- * key
              next_state <= s0;
            when "0000" => -- 0 key
              duty_cycle <= to_unsigned(0, 8);
            when "0001" => -- 1 key
              duty_cycle <= to_unsigned(10, 8);
            when "0010" => -- 2 key
              duty_cycle <= to_unsigned(20, 8);
            when "0011" => -- 3 key
              duty_cycle <= to_unsigned(30, 8);
            when "0100" => -- 4 key
              duty_cycle <= to_unsigned(40, 8);
            when "0101" => -- 5 key
              duty_cycle <= to_unsigned(50, 8);
            when "0110" => -- 6 key
              duty_cycle <= to_unsigned(60, 8);
            when "0111" => -- 7 key
              duty_cycle <= to_unsigned(70, 8);
            when "1000" => -- 8 key
              duty_cycle <= to_unsigned(80, 8);
            when "1001" => -- 9 key
              duty_cycle <= to_unsigned(90, 8);
            when "1010" => -- A key
              duty_cycle <= to_unsigned(100, 8);
            when others =>
              next_state <= s4;
          end case;
        when others =>
          next_state <= s0;
      end case;
    end if;
  end process;

  current_state_output : process(current_state)
    begin
      case current_state is
        when s0 =>
          o_busy <= '0';
          o_unlocked <= '0';
        when s1 =>
          o_busy <= '1';
          o_unlocked <= '0';
        when s2 =>
          o_busy <= '1';
          o_unlocked <= '0';
        when s3 =>
          o_busy <= '1';
          o_unlocked <= '0';
        when s4 =>
          o_busy <= '0';
          o_unlocked <= '1';
        when others =>
          o_busy <= '0';
          o_unlocked <= '0';
      end case;
    end process;
end architecture behave;
