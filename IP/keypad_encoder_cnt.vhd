library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keypad_encoder_cnt is
  port (
    -- Clock and reset
  i_clk, i_rst : in std_logic;

    -- Interfacing with the keypad
  i_col : in std_logic_vector(3 downto 0);
  o_row : out std_logic_vector(3 downto 0);

    -- Output to the user
  o_pressed : out std_logic;
  o_key : out std_logic_vector(3 downto 0));
end entity;

architecture rtl of keypad_encoder_cnt is
  constant n_sel_bits : integer := 2;
  signal s_key : std_logic_vector(3 downto 0);

  -- Counter
  signal s_cnt : std_logic_vector(3 downto 0);
  signal s_pressed : std_logic;
begin
  encoder_inst : entity work.nbit_decoder
  generic map(
    n_sel_bits => n_sel_bits  -- number of input bits (default: 8)
  )
  port map(
    data => std_logic_vector(s_cnt(3 downto 2)),  -- input data
    output => o_row
  );

  counter_inst : entity work.counter
  generic map(
    n_bits => 4
  )
  port map(
    i_en => not s_pressed,
    i_clk => i_clk,
    i_rst => i_rst,
    o_cnt => s_cnt
  );

  mux_inst : entity work.multiplexer
    generic map(
        n_sel_bits => 2
    )
    port map(
        sel => std_logic_vector(s_cnt(1 downto 0)),
        din  => i_col,
        dout => s_pressed
    );

  process(s_pressed, s_cnt)
  begin
    if s_pressed = '1' then
      case s_cnt is
        when "0000" => s_key <= "0001"; -- 1
        when "0001" => s_key <= "0010"; -- 2
        when "0010" => s_key <= "0011"; -- 3
        when "0011" => s_key <= "1010"; -- A
        when "0100" => s_key <= "0100"; -- 4
        when "0101" => s_key <= "0101"; -- 5
        when "0110" => s_key <= "0110"; -- 6
        when "0111" => s_key <= "1011"; -- B
        when "1000" => s_key <= "0111"; -- 7
        when "1001" => s_key <= "1000"; -- 8
        when "1010" => s_key <= "1001"; -- 9
        when "1011" => s_key <= "1100"; -- C
        when "1100" => s_key <= "1110"; -- *
        when "1101" => s_key <= "0000"; -- 0
        when "1110" => s_key <= "1111"; -- #
        when "1111" => s_key <= "1101"; -- D
        when others => null;
      end case;
    end if;
  end process;
  o_pressed <= s_pressed;
  o_key <= s_key;

  

  end architecture;
