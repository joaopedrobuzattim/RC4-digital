library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Division8bit_tb is
end Division8bit_tb;

architecture test of Division8bit_tb is
    -- Signals to connect to the DUT
    signal d : std_logic_vector(7 downto 0);
    signal m : std_logic_vector(7 downto 0);
    signal r : std_logic_vector(7 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    A_8_BIT_DIVISOR: entity work.Division8Bit(Behavioral)
        port map (
            numerator => d,
            denominator => m,
            remainder => r
        );

    -- Test process
    process
    begin
        -- Test case 1: 100 / 10
        d <= "01100100";  -- 100 in binary
        m <= "00001010";  -- 10 in binary
        wait for 20 ns;


        -- Test case 2: 255 / 15
        d <= "11111111";  -- 255 in binary
        m <= "00001110";  -- 15 in binary
        wait for 20 ns;

        wait;
    end process;
end test;
