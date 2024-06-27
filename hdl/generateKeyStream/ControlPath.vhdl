library IEEE;
use IEEE.std_logic_1164.all;
use work.GenerateKeyStream_pkg.all;

entity ControlPath is
    port (  
        clk         : in std_logic;
        rst         : in std_logic;

        data_av     : in std_logic;
        done        : out std_logic;

        sel, ld     : out std_logic;
        

        sts         : in Status;
        cmd         : out Command      
    );
end ControlPath;
                   

architecture behavioral of ControlPath is       
    type States is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
    signal currentState, nextState : States;
begin

    process(clk, rst)
    begin
        if rst = '1' then
            currentState <= S0;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;
    
    process(currentState, data_av, sts.k_lt_textSize)
    begin
        case currentState is
            when S0 =>
                if data_av = '1' then
                    nextState <= S1;
                else
                    nextState <= S0;
                end if;
            when S1 =>                                   
                if data_av = '1' then
                    nextState <= S2;
                else
                    nextState <= S1;
                end if;
            when S2 =>                                    
                if data_av = '1' then
                    nextState <= S3;
                else
                    nextState <= S2;
                end if;
            when S3 =>                                     
                if data_av = '1' then
                    nextState <= S4;
                else
                    nextState <= S3;
                end if;
            when S4 => 
                if sts.k_lt_textSize = '1' then
                    nextState <= S5;
                else
                    nextState <= S0;
                end if;   
            when S5 =>
                nextState <= S6;
            when S6 =>
                nextState <= S7;
            when S7 =>
                nextState <= S8;
            when S8 =>
                nextState <= S9;
            when S9 =>
                nextState <= S10;
            when S10 =>
                nextState <= S11;
            when S11 =>
                nextState <= S12;
            when S12 =>
                nextState <= S13;
            when S13 =>
                nextState <= S14;
            when S14 =>
                nextState <= S4;            
        end case;
    end process;
    

    done            <= '1' when (currentState = S4 and sts.k_lt_textSize = '0') else '0';

    sel             <= '1' when (currentState = S5  or 
                                currentState = S7   or 
                                currentState = S8   or 
                                currentState = S9   or
                                currentState = S10  or
                                currentState = S12  or
                                currentState = S13) else '0';
    ld              <= '1' when (currentState = S5  or 
                                currentState = S7   or 
                                currentState = S10  or
                                currentState = S12) else '0';


    cmd.wrI      <= '1' when (currentState = S4 and sts.k_lt_textSize = '1') else '0';
    cmd.wrJ      <= '1' when currentState = S6 else '0';
    cmd.wrT      <= '1' when (currentState = S11 or currentState = S6) else '0';
    cmd.wrK      <= '1' when currentState = S14 else '0';

    cmd.selSum0    <= '1' when (currentState = S6  or 
                                currentState = S7  or 
                                currentState = S9  or 
                                currentState = S13 or 
                                currentState = S14) else '0';
    cmd.selSum1    <= '1' when (currentState = S11  or 
                                currentState = S12  or 
                                currentState = S13  or 
                                currentState = S14) else '0';
    cmd.selSum2    <= '1' when (currentState = S6  or 
                                currentState = S11  or 
                                currentState = S13) else '0';
    cmd.selSum3    <= '1' when (currentState = S5  or 
                                currentState = S7  or 
                                currentState = S8  or
                                currentState = S9  or
                                currentState = S10 or
                                currentState = S12 or
                                currentState = S13) else '0';
    cmd.selT        <= '1' when (currentState = S6 or currentState = S9) else '0';
    
    cmd.clearAux    <= '1' when currentState = S3 else '0';
                            
    
    cmd.wrState         <= '1' when currentState = S0 else '0';
    cmd.wrStateSize     <= '1' when currentState = S1 else '0';
    cmd.wrTextSize      <= '1' when currentState = S2 else '0';
    cmd.wrKeyStream     <= '1' when currentState = S3 else '0';      
end behavioral;
