library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity counter_tb is
end counter_tb;

architecture behave of counter_tb is
  constant counter_bits : positive := 4;
  
  component counter
    generic (
              n_bits : positive := counter_bits
    );
    port (
    i_enable : in std_logic;
    i_clk : in std_logic;
    i_reset : in std_logic;

    o_cnt : out std_logic_vector(counter_bits-1 downto 0)
    );
    end component;
      

  constant clk_freq : positive := 125000000;
  constant clk_period : time := 1 sec / clk_freq;
  signal clk : std_logic := '0';

  signal rst : std_logic := '0';
  signal en : std_logic := '1';

  signal cnt : std_logic_vector(counter_bits-1 downto 0);

begin
    -- Clock
    clk <= not clk after clk_period / 2;

    DUT : counter 
    generic map (n_bits => counter_bits)
    port map ( i_enable => en, i_clk => clk, i_reset => rst, o_cnt => cnt);

  process begin
    wait for clk_period * 1000;
    finish;
  end process;
end behave;
