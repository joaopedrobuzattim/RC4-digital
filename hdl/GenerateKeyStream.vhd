-------------------------------------------------------------------------
-- Design unit: BubbleSort
-- Description: BubbleSort top (Control path + Data path) 
--------------------------------------------------------------------------


library IEEE;                        
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use work.BubbleSort_pkg.all;

entity GenerateKeyStream  is
    generic(
        DATA_WIDTH  : integer := 8
    );
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        data_av     : in std_logic;
        data        : in std_logic_vector (DATA_WIDTH - 1 downto 0); 
        data_in     : in std_logic_vector (DATA_WIDTH - 1 downto 0);   
        done        : out std_logic;
        address     : out std_logic_vector (DATA_WIDTH - 1 downto 0);
        data_out    : out std_logic_vector (DATA_WIDTH - 1 downto 0);
        sel         : out std_logic;
        ld          : out std_logic
    );
        
end GenerateKeyStream;

-- architecture structural of BubbleSort is  
        
--     signal cmd: Command;
--     signal sts: Status;
    
-- begin


--     CONTROL_PATH: entity work.ControlPath
--         port map (
--             clk     => clk,
--             rst     => rst,
--             start   => start,    
--             done    => done,    
--             wr      => wr,
--             cmd     => cmd,
--             sts     => sts
            
            
--     );
        
--     DATA_PATH: entity work.DataPath
--         generic map (
--             DATA_WIDTH  => DATA_WIDTH,
--             ADDR_WIDTH  => ADDR_WIDTH
--         )
--         port map (
--             clk         => clk,
--             rst         => rst,
--             startAddr   => startAddr,
--             size        => size,
--             cmd         => cmd,
--             sts         => sts,
--             dataIn      => dataIn,
--             dataOut     => dataOut,
--             address     => address,
--             up          => up
--         );
        
-- end structural;


architecture behavioral of GenerateKeyStream is 

    type States is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
    signal currentState: States;
    
    signal state, stateSize, textSize, keyStream : UNSIGNED(DATA_WIDTH - 1 downto 0);
    signal i, j, k, t, mem                       : UNSIGNED(DATA_WIDTH - 1 downto 0);
    signal sumOut, dataOut                       : UNSIGNED(DATA_WIDTH - 1 downto 0);

begin
    process(clk, rst)
    begin
        if rst = '1' then
            currentState <= S0;
        elsif rising_edge(clk) then
            case currentState is
                when S0 =>
                    state <= UNSIGNED(data);
                    if data_av = '1' then
                        currentState <= S1;
                    else
                        currentState <= S0;
                    end if;
                when S1 =>
                    stateSize <= UNSIGNED(data);                                      
                    if data_av = '1' then
                        currentState <= S2;
                    else
                        currentState <= S1;
                    end if;
                when S2 =>
                    textSize <= UNSIGNED(data);                                      
                    if data_av = '1' then
                        currentState <= S3;
                    else
                        currentState <= S2;
                    end if;
                when S3 =>
                    keyStream <= UNSIGNED(data);
                    i <= (others => '0');
                    j <= (others => '0');
                    k <= (others => '0');
                    t <= (others => '0');                                      
                    if data_av = '1' then
                        currentState <= S4;
                    else
                        currentState <= S3;
                    end if;
                when S4 =>
                    if k /= textSize then
                        i <= UNSIGNED(to_signed( (to_integer(i+1) mod to_integer(stateSize)) , DATA_WIDTH));
                        currentState <= S5;
                    else
                        currentState <= S0;
                    end if;
                when S5 => 
                    currentState <= S6;
                when S6 =>
                    j <= UNSIGNED(to_signed(to_integer(j + UNSIGNED(data_in)) mod to_integer(stateSize), DATA_WIDTH));
                    t <= UNSIGNED(data_in);
                    currentState <= S7;
                when S7 =>                
                    currentState <= S8;
                when S8 =>
                    currentState <= S9;
                when S9 =>
                    currentState <= S10;
                when S10 =>
                    currentState <= S11;
                when S11 =>
                    t <= UNSIGNED(to_signed(to_integer(t + UNSIGNED(data_in)) mod to_integer(stateSize), DATA_WIDTH));
                    currentState <= S12;
                when S12 =>
                    currentState <= S13;
                when S13 =>
                    currentState <= S14;
                when S14 =>
                    k <= UNSIGNED(k + 1);
                    currentState <= S4;   
                when others =>
                    currentState <= S0;
            end case;
        end if;
    end process;
    



    sel <= '1' when (currentState = S5  or 
                     currentState = S7  or 
                     currentState = S8  or 
                     currentState = S9  or 
                     currentState = S10 or
                     currentState = S12 or
                     currentState = S13
                     ) else '0';
    
    ld <= '1' when (currentState = S5  or 
                    currentState = S7  or 
                    currentState = S10 or 
                    currentState = S12
                    ) else '0';
    
    process(currentState, state, i, j, t, k, stateSize, keyStream)
    begin
        case currentState is
            when S5 | S8 | S10 =>
                sumOut <= state + i;
            when S7 | S9 =>
                sumOut <= state + j;
            when S12 =>
                sumOut <= state + t;
            when S13 =>
                sumOut <= keyStream + k;
            when others =>
                sumOut <= (others => '0');
        end case;
    end process;

    address <= STD_LOGIC_VECTOR(sumOut);

    process(currentState, mem, t)
    begin
        case currentState is
            when S8 | S13 =>
                dataOut <= UNSIGNED(data_in);
            when S9 =>
                dataOut <= t;
            when others =>
                dataOut <= (others => '0');
        end case;
    end process;

    data_out <= STD_LOGIC_VECTOR(dataOut);

    done        <= '1' when currentState = S4 and k = textSize else '0';
end behavioral;