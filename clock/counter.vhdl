library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic (
    -- 6 bits for the counter to count from 0 to 63
    n_bits : integer := 6
  );

  port (
    i_clk : in std_logic;
    i_rst  : in std_logic;

    o_sec_cnt : out std_logic_vector(n_bits-1 downto 0);
    o_min_cnt : out std_logic_vector(n_bits-1 downto 0)
  );
end counter;

architecture structure of counter is
begin
  counter_process : process(i_clk, i_rst)
    variable v_min_cnt : unsigned(n_bits-1 downto 0) := (others => '0');
    variable v_sec_cnt : unsigned(n_bits-1 downto 0) := (others => '0');
  begin
    if i_rst = '1' then
      v_min_cnt := (others => '0');
      v_sec_cnt := (others => '0');
    elsif rising_edge(i_clk) then
      if v_sec_cnt = 59 then
        v_sec_cnt := (others => '0');
        if v_min_cnt = 59 then
          v_min_cnt := (others => '0');
        else
          v_min_cnt := v_min_cnt + 1;
        end if;
      else
        v_sec_cnt := v_sec_cnt + 1;
      end if;
    end if;

    o_sec_cnt <= std_logic_vector(v_sec_cnt);
    o_min_cnt <= std_logic_vector(v_min_cnt);
  end process;
end structure;
