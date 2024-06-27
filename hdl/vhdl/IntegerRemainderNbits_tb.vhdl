library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;


entity IntegerRemainderNbits_tb is
end IntegerRemainderNbits_tb;

architecture test of IntegerRemainderNbits_tb is
    -- Component declaration
    component IntegerRemainderNbits
        generic (
            WIDTH : integer := 8
        );
        port (
            nominator   : in  std_logic_vector(WIDTH - 1 downto 0);
            denominator : in  std_logic_vector(WIDTH - 1 downto 0);
            remainder   : out std_logic_vector(WIDTH - 1 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal nominator   : std_logic_vector(7 downto 0);
    signal denominator : std_logic_vector(7 downto 0);
    signal remainder   : std_logic_vector(7 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    uut: IntegerRemainderNbits
        generic map (
            WIDTH => 8
        )
        port map (
            nominator   => nominator,
            denominator => denominator,
            remainder   => remainder
        );

    -- Test process
    process
    begin
        -- Test case 1: 10 % 3 = 1
        nominator <= "00001010";  -- 10 in binary
        denominator <= "00000011";  -- 3 in binary

        finish;
    end process;
end test;
