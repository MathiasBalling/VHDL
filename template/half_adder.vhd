library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
  port (
    i_A : in std_logic;
    i_B  : in std_logic;

    o_S : out std_logic;
    o_C : out std_logic
  );
end half_adder;

architecture rtl of half_adder is
begin
  o_S <=i_A xor i_B;
  o_C <=i_A and i_B;
end rtl;
