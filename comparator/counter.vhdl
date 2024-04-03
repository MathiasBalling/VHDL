library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity counter is
  generic (
    WIDTH : integer := 8
    );
  port (
  i_enable : in std_logic;

    );
end counter;
 
architecture rtl of counter is
begin
  process(i_enable)
  begin
  end process;
end rtl;
