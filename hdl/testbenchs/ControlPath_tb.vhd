library IEEE;                        
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.GenerateKeyStream_pkg.all;

use std.env.finish;


entity ControlPath_tb  is
end ControlPath_tb;


architecture behavioral of ControlPath_tb is      
    signal clk                : std_logic := '0';
    signal rst, data_av       : std_logic ;
    signal sts: Status;
    signal sel, ld            : std_logic;
    signal done               : std_logic;
    signal cmd: Command;
begin
    -- Generates the stimuli.
    clk <= not clk after 20 ns;    -- 25 MHz
    
    CONTROL_PATH: entity work.ControlPath
    port map (
        clk         => clk,
        rst         => rst,
        data_av     => data_av,
        sts         => sts,
        cmd         => cmd,
        sel         => sel,
        ld         => ld,
        done         => done
    );

    process
    begin
        rst <= '1';
        wait until  clk = '1';
        wait until  clk = '1';
        rst <= '0';
        wait until  clk = '1';
        data_av <= '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        sts.k_lt_textSize <= '1';
        data_av <= '0';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        wait until  clk = '1';
        sts.k_lt_textSize <= '0';    
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


