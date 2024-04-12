library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity edl_controller is
  port (
  clk, rst, intr : in std_logic;
  key : in std_logic_vector(3 downto 0);
  busy, unlock : out std_logic
    );
end edl_controller;
 
architecture behave of edl_controller is 
  type state_type is (s0,s1,s2,s3,s4);
  signal current_state, next_state : state_type;
begin
  clocked_process : process(clk, rst)
    begin
      if rst = '1' then
        current_state <= s0;
      elsif rising_edge(clk) then
        current_state <= next_state;
      end if;
    end process;
     
  next_state_logic : process(current_state,intr)
  begin
    case current_state is
      when s0 =>
      if intr = '1' and key = "0100" then
        next_state <= s1;
      else
        next_state <= s0;
      end if;
      when s1 =>
        if intr = '1' and key = "0101" then
          next_state <= s2;
        else
          next_state <= s0;
        end if;
      when s2 =>
        if intr = '1' and key = "0110" then
          next_state <= s3;
        else
          next_state <= s0;
        end if;
      when s3 =>
        if intr = '1' and key = "0111" then
          next_state <= s4;
        else
          next_state <= s0;
        end if;
      when s4 =>
        if intr = '1' and key = "0111" then
          next_state <= s0;
        else
          next_state <= s0;
        end if;
      when others =>
        next_state <= s0;
    end case;
  end process;

  current_state_output : process(current_state)
    begin
      case current_state is
        when s0 =>
          busy <= '0';
          unlock <= '0';
        when s1 =>
          busy <= '1';
          unlock <= '0';
        when s2 =>
          busy <= '1';
          unlock <= '0';
        when s3 =>
          busy <= '1';
          unlock <= '0';
        when s4 =>
          busy <= '1';
          unlock <= '1';
        when others =>
          busy <= '0';
          unlock <= '0';
      end case;
    end process;
end architecture behave;
