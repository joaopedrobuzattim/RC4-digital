library IEEE;                        
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

-- Test bench interface is always empty.
entity GenerateKeyStream_tb  is
end GenerateKeyStream_tb;


-- Instantiate the components and generates the stimuli.
architecture behavioral of GenerateKeyStream_tb is      
    constant DATA_WIDTH       : integer :=  8;
    constant ADDR_WIDTH       : integer :=  8;

    signal clk                : std_logic := '0';
    signal rst, data_av       : std_logic;

    -- Entrada de dados de GenerateKeyStream
    signal data_in, data      : std_logic_vector(DATA_WIDTH-1 downto 0);

    -- Saída de dados de GenerateKeyStream
    signal address, dataOut   : std_logic_vector(DATA_WIDTH-1 downto 0);

    --Saída de dados da memória
    signal dataOutMem         : std_logic_vector(DATA_WIDTH-1 downto 0);

    -- Controle de memória
    signal sel, ld            : std_logic;
    -- Saída done de GenerateKeyStream
    signal done               : std_logic;
begin

    GENERATE_KEYSTREAM: entity work.GenerateKeyStream(behavioral) 
        generic map (
            DATA_WIDTH    => DATA_WIDTH
        )
        port map (
            clk         => clk,
            rst         => rst,
            data_av     => data_av,
            done        => done,
            data_in     => data_in,
            data        => data,
            -- Memory interface
            sel         => sel,
            ld          => ld,
            data_out     => dataOut,
            address     => address
        );
        
    RAM1: entity work.Memory
        generic map (
            DATA_WIDTH    => DATA_WIDTH,
            ADDR_WIDTH    => ADDR_WIDTH,
            imageFileName   => "image.txt"
        )
        port map (
            clock       => clk,
            ce          => sel,
            wr          => not(ld),
            data_i      => dataOut,
            data_o      => dataOutMem,
            address     => address
        );
        
    REG_MEM: entity work.RegisterNbits
        generic map (
            WIDTH => DATA_WIDTH
        )
        port map (
            clock   =>  clk,
            reset   =>  rst,
            ce      =>  sel,
            d       =>  dataOutMem,
            q       =>  data_in
        );
    -- -- Instantiates the units under test.
    -- PROCESSOR_STR: entity work.GenerateKeyStream(structural) 
    --     generic map (
    --         DATA_WIDTH    => DATA_WIDTH,
    --         ADDR_WIDTH    => ADDR_WIDTH
    --     )
    --     port map (
    --         clk         => clk,
    --         rst         => rst,
    --         start       => start,
    --         startAddr   => startAddr,
    --         size        => size,
    --         up          => up,
            
    --         -- Memory interface
    --         wr          => wr2,
    --         dataIn      => bs2_data_i,
    --         dataOut     => bs2_data_o,
    --         address     => address2
    --     );
        
    -- RAM2: entity work.Memory
    --     generic map (
    --         DATA_WIDTH    => DATA_WIDTH,
    --         ADDR_WIDTH    => ADDR_WIDTH,
    --         imageFileName   => "image.txt"
    --     )
    --     port map (
    --         clock       => clk,
    --         ce          => '1',
    --         wr          => wr2,
    --         data_i      => bs2_data_o,
    --         data_o      => bs2_data_i,
    --         address     => address2
    --     );
        
    -- Generates the stimuli.
    clk <= not clk after 20 ns;    -- 25 MHz
    
    process
    begin
        rst <= '1';
        wait until  clk = '1';
        wait until  clk = '1';
        rst <= '0';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';

        data <= (others => '0');
        data_av <= '1';
        wait until  clk = '1';
        data_av <= '0';

        wait until  clk = '1';
        wait until  clk = '1';

        data <= "00000100";
        data_av <= '1';
        wait until  clk = '1';
        data_av <= '0';

        
        wait until  clk = '1';
        wait until  clk = '1';

        data <= "00000010";
        data_av <= '1';
        wait until  clk = '1';
        data_av <= '0';

        wait until  clk = '1';
        wait until  clk = '1';

        data <= "00000100";
        data_av <= '1';
        wait until  clk = '1';
        data_av <= '0';

        wait until done = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';

        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';

        
        finish;

    end process;
end behavioral;


