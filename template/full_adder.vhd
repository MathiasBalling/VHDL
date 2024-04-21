library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
  port (
    i_A : in std_logic;
    i_B  : in std_logic;
    i_C : in std_logic;

    o_S : out std_logic;
    o_C : out std_logic
  );
end full_adder;

architecture rtl of full_adder is
  component half_adder
    port (
      i_A : in std_logic;
      i_B  : in std_logic;

      o_S : out std_logic;
      o_C : out std_logic
    );
  end component;

  -- internal signals(wires)
  signal carry1 : std_logic;
  signal carry2 : std_logic;
  signal sum1 : std_logic;
begin
  ha1 : half_adder
    port map (i_A => i_A, i_B => i_B, o_S => sum1, o_C => carry1);

  ha2 : half_adder
    port map (i_A => sum1, i_B => i_C, o_S => o_S, o_C => carry2);

  o_C <= carry1 or carry2;
end rtl;
