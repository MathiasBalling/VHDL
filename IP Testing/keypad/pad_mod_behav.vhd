-- vhdl entity pad_mod
--
-- created:
--          by - emad samuel 
--          at - 10:10:01 26/09/2019
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pad_mod is
   port( 
      key_pressed : in     std_logic_vector (4 downto 0);
      rows        : in     std_logic_vector (3 downto 0);
      cols        : out    std_logic_vector (3 downto 0)
   );

-- declarations

end pad_mod ;

-- hds interface_end

-- hds interface_end


-- hds interface_end
architecture behav of pad_mod is
begin
process(rows,key_pressed)
  variable cols_var: std_logic_vector(3 downto 0);
begin
cols_var:= "0000";
if (key_pressed(4)='1') then
cols_var(conv_integer(unsigned(key_pressed(1 downto 0)))):=rows(conv_integer(unsigned(key_pressed(3 downto 2)))) ;
else 
cols_var:= "0000";
end if;
cols<= cols_var;
end process;

end behav;

