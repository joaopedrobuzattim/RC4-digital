library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IntegerRemainderNbits is
    Port (
        numerator : in  STD_LOGIC_VECTOR (7 downto 0);
        denominator : in  STD_LOGIC_VECTOR (7 downto 0);
        remainder : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end IntegerRemainderNbits;

architecture Behavioral of IntegerRemainderNbits is
begin
    process(numerator, denominator)
        variable ac : UNSIGNED(15 downto 0);
        variable Mbar : UNSIGNED(7 downto 0);
    begin
        Mbar := not UNSIGNED(denominator);
        ac := "00000000" & UNSIGNED(numerator);
        for i in 1 to 8 loop
            ac := ac(14 downto 0) & '0';
            ac(15 downto 8) := ac(15 downto 8) + Mbar + "00000001";
            if ac(15) = '1' then
                ac(0) := '0';
                ac(15 downto 8) := ac(15 downto 8) + UNSIGNED(denominator);
            else
                ac(0) := '1';
            end if;
        end loop;
        remainder <= STD_LOGIC_VECTOR(ac(15 downto 8));
    end process;
end Behavioral;