library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;
 
entity nbit_encoder_tb is
end nbit_encoder_tb;
 
architecture behave of nbit_encoder_tb is
  constant n_sel_bits : integer := 2;
    signal data :std_logic_vector(n_sel_bits-1 downto 0);
    signal output :std_logic_vector(2**n_sel_bits-1 downto 0);
begin
  encoder_inst : entity work.nbit_decoder
  generic map(
    n_sel_bits => n_sel_bits  -- number of input bits (default: 8)
  )
  port map(
    data => data,
    output => output
  );

  process is
  begin
    data <= "00";
    wait for 10 ns;
    data <= "01";
    wait for 10 ns;
    data <= "10";
    wait for 10 ns;
    data <= "11";
    wait for 10 ns;
    finish;
  end process;
end behave;
