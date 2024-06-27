library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.GenerateKeyStream_pkg.all;

entity DataPath is
    generic (
        DATA_WIDTH  : integer := 8
    );
    port (  
        clk         : in std_logic;
        rst         : in std_logic;

        data        : in std_logic_vector (DATA_WIDTH - 1 downto 0);
        
        -- Control path interface
        sts         : out Status;
        cmd         : in Command;
        
        -- Memory interface
        addr     : out std_logic_vector (DATA_WIDTH - 1 downto 0);
        data_in  : in std_logic_vector (DATA_WIDTH - 1 downto 0);
        data_out : out std_logic_vector (DATA_WIDTH - 1 downto 0)
    );
end DataPath;


architecture behavioral of DataPath is
    signal state, stateSize, textSize, keyStream :   std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal i, j, t, k                            :   std_logic_vector(DATA_WIDTH - 1 downto 0);
    
    signal muxSum1Select, muxSum2Select          :   std_logic_vector(1 downto 0);
    signal muxSum1, muxSum2                      :   std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal muxT                                  :   std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal muxDataOut                            :   std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal sum                                   :   UNSIGNED(DATA_WIDTH - 1 downto 0);
    signal rest                                  :   std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal sub                                   :   SIGNED(DATA_WIDTH - 1 downto 0);
begin

    REG_STATE: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => rst,
            ce      => cmd.wrState,
            d       => data,
            q       => state            
        );
    REG_STATE_SIZE: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => rst,
            ce      => cmd.wrStateSize,
            d       => data,
            q       => stateSize            
        );
    REG_TEXT_SIZE: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => rst,
            ce      => cmd.wrTextSize,
            d       => data,
            q       => textSize            
        );
    REG_KEY_STREAM: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => rst,
            ce      => cmd.wrKeyStream,
            d       => data,
            q       => keyStream            
        );

    REG_I: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => (rst or cmd.clearAux),
            ce      => cmd.wrI,
            d       => rest,
            q       => i            
        );
    REG_J: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => (rst or cmd.clearAux),
            ce      => cmd.wrJ,
            d       => rest,
            q       => j            
        );
    REG_T: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => (rst or cmd.clearAux),
            ce      => cmd.wrT,
            d       => muxT,
            q       => t            
        );
    REG_K: entity work.RegisterNbits
        generic map (
            WIDTH   => DATA_WIDTH
        )
        port map (
            clock   => clk,
            reset   => (rst or cmd.clearAux),
            ce      => cmd.wrK,
            d       => STD_LOGIC_VECTOR(sum),
            q       => k            
        );
    
    
    -- Multiplexadores

    muxSum1Select(0) <= cmd.selSum2;
    muxSum1Select(1) <= cmd.selSum3;
    process(muxSum1Select, data_in, state, keyStream)
    begin
        case muxSum1Select is
            when "00" =>
                muxSum1 <= "00000001";
            when "01" =>
                muxSum1 <= data_in;
            when "10" =>
                muxSum1 <= state;
            when others =>
                muxSum1 <= keyStream;
        end case;
    end process;

    muxSum2Select(0) <= cmd.selSum0;
    muxSum2Select(1) <= cmd.selSum1;
    process(muxSum2Select, i, j, t, k)
    begin
        case muxSum2Select is
            when "00" =>
                muxSum2 <= i;
            when "01" =>
                muxSum2 <= j;
            when "10" =>
                muxSum2 <= t;
            when others =>
                muxSum2 <= k;
        end case;
    end process;

    process(cmd.selT, rest, data_in)
    begin
        muxT <= data_in when cmd.selT = '1' else rest;
    end process;

    process(cmd.selT, t, data_in)
    begin
        muxDataOut <= t when cmd.selT = '1' else data_in;
    end process;



    -- Somador
    sum <= UNSIGNED(muxSum1) + UNSIGNED(muxSum2);

    -- Subtrator
    sub <= SIGNED(UNSIGNED(k) - UNSIGNED(textSize));

    -- Resto da divisão inteira
    INTEGER_REMAINDER: entity work.IntegerRemainderNbits
    generic map (
        WIDTH   => DATA_WIDTH
    )        
    port map (
        numerator       => STD_LOGIC_VECTOR(sum),
        denominator     => stateSize,
        remainder       => rest            
    );     
        
    -- Saídas
    addr <= STD_LOGIC_VECTOR(sum);

    data_out <= muxDataOut;

    sts.k_lt_textSize <= sub(7);

        
end behavioral;