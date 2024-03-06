library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           SORTIE : out  STD_LOGIC);
end EX;

architecture Behavioral of EX is

signal compt : integer range 0 to 7 ;
signal etat : bit;

begin    -- Stimulus process
    process (CLK)
    begin
        if CLK'event and CLK = '1' then
            if EN = '1' then
                compt <= compt + 1;
                case etat is
                    when '0' => if compt = 3 then compt <= 0; SORTIE <= '1'; etat <= '1'; end if;
                    when '1' => if compt = 2 then compt <= 0; SORTIE <= '0'; etat <= '0'; end if;
                end case;
            end if;
        end if;
    end process;
end Behavioral;
