library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;


entity IntegerRemainderNbits_tb is
end IntegerRemainderNbits_tb;

architecture test of IntegerRemainderNbits_tb is
    constant WIDTH       : integer :=  32;


    signal numerator   : std_logic_vector(WIDTH -1 downto 0);
    signal denominator : std_logic_vector(WIDTH -1 downto 0);
    signal remainder   : std_logic_vector(WIDTH -1 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    INTEGER_REMAINER_NBITS: entity work.IntegerRemainderNbits
        generic map (
            WIDTH => WIDTH
        )
        port map (
            numerator   => numerator,
            denominator => denominator,
            remainder   => remainder
        );

    -- Test process 
    process
    begin
        numerator   <= "00000000000000000000000000001010";  -- 10 
        denominator <= "00000000000000000000000000000011";  -- 3

        wait for 20 ns;
        wait;
    end process;
end test;
