LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY EXTB IS
END EXTB;
 
ARCHITECTURE behavior OF EXTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT EX
    PORT(
         CLK : IN  std_logic;
         EN : IN  std_logic;
         SORTIE : OUT  std_logic
        );
    END COMPONENT;
        

    --Inputs
    signal CLK : std_logic := '0';
    signal EN : std_logic := '1';

    -- Inner
    signal compt : integer range 0 to 7 ;
    signal etat : bit;

    --Outputs
    signal SORTIE : std_logic;

    -- Clock period definitions
     constant CLK_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: EX PORT MAP (
          CLK => CLK,
          EN => EN,
          SORTIE => SORTIE
        );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
     

    -- Stimulus process
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

END;
