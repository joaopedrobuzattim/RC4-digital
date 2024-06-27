-------------------------------------------------------------------------------------------------------------------------------------------------
-- Esse código foi uma adaptação do Divisor Binário de 4 Bits construído em: https://www.youtube.com/watch?v=cKT3NLByYhY
-- O código foi modificado para aceitar um divisor de N bits, onde N é um valor genérico.
-- O código original esá disponível em: https://docs.google.com/presentation/d/1WftZ2jEhHxDFjTUBy7V8AHFdNwBIcFuE/edit#slide=id.p22
-------------------------------------------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IntegerRemainderNbits is
    generic (
        WIDTH : integer := 8
    );
    Port (
        numerator : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        denominator : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        remainder : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end IntegerRemainderNbits;

architecture Behavioral of IntegerRemainderNbits is
begin
    process(numerator, denominator)
        variable ac : UNSIGNED((2*WIDTH)-1 downto 0);
        variable Mbar : UNSIGNED(WIDTH-1 downto 0);
    begin
        Mbar := not UNSIGNED(denominator);
        ac(2*WIDTH - 1 downto WIDTH) := (others => '0');
        ac(WIDTH -1 downto 0) :=  UNSIGNED(numerator);
        for i in 1 to WIDTH loop
            ac := ac((2*WIDTH)-2 downto 0) & '0';
            ac((2*WIDTH)-1 downto WIDTH) := ac((2*WIDTH)-1 downto WIDTH) + Mbar + 1;
            if ac((2*WIDTH)-1) = '1' then
                ac(0) := '0';
                ac((2*WIDTH)-1 downto WIDTH) := ac((2*WIDTH)-1 downto WIDTH) + UNSIGNED(denominator);
            else
                ac(0) := '1';
            end if;
        end loop;
        remainder <= STD_LOGIC_VECTOR(ac((2*WIDTH)-1 downto WIDTH));
    end process;
end Behavioral;
