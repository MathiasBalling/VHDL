library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity counter is
  port (
  i_enable : in std_logic;
  i_data  : in std_logic;

  o_q : out std_logic;
  o_qn : out std_logic
    );
end counter;
 
architecture structure of counter is
begin
  process(i_enable)
  begin
    if rising_edge(i_enable) then
      o_q <= i_data;
      o_qn <= not i_data;
    end if;
  end process;
end structure;
