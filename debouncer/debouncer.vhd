library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity debouncer is
  port (
  clk, rst, inp : in std_logic;
  outp : out std_logic
    );
end debouncer;
 
architecture rtl of debouncer is 
  type state_type is (S0, S1, S2);
  signal current_state : state_type;
  signal next_state : state_type;
begin
  clocked_process: process(clk, rst)
    begin
      if rst = '1' then
      current_state <= S0;
      elsif rising_edge(clk) then
      current_state <= next_state;
      end if;
    end process;

  next_state_logic : process(current_state, inp)
    begin
      case current_state is
        when S0 =>
          if inp = '1' then
            next_state <= S1;
          else
            next_state <= S0;
          end if;
        when S1 =>
          if inp = '1' then
            next_state <= S2;
          else
            next_state <= S0;
          end if;
        when S2 =>
          if inp = '1' then
            next_state <= S2;
          else
            next_state <= S0;
          end if;
      end case;
    end process;

  current_state_logic : process(current_state)
    begin
      case current_state is
        when S0 =>
          outp <= '0';
        when S1 =>
          outp <= '1';
        when S2 =>
          outp <= '0';
      end case;
    end process;
end architecture rtl;
