library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity d_latch is
  port (
  i_enable : in std_logic;
  i_data  : in std_logic;

  o_q : out std_logic;
  o_qn : out std_logic
    );
end d_latch;
 
architecture rtl of d_latch is
begin
  process(i_enable, i_data)
  begin
    if i_enable = '1' then
      o_q <= i_data;
      o_qn <= not i_data;
    end if;
  end process;
end rtl;
