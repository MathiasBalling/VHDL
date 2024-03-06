library ieee;
use ieee.std_logic_1164.all;

entity Priority_Encoder is
  port (D : in std_logic_vector(3 downto 0);
        Y : out std_logic_vector(1 downto 0));
end Priority_Encoder;

architecture rtl of Priority_Encoder is
begin
  if(D(3) = '1') then
    Y <= "11";
  elsif(D(2) = '1') then
    Y <= "10";
  elsif(D(1) = '1') then
    Y <= "01";
  elsif(D(0) = '1') then
    Y <= "00";
  else
    Y <= "--";
  end if;
end rtl;
