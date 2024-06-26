library IEEE;
use IEEE.std_logic_1164.all;

package GenerateKeyStream_pkg is
    type Command is record
        wrI, wrJ, wrT, wrK                            : std_logic;
        selSum0, selSum1, selSum2, selSum3, selT      : std_logic;
        clearAux                                      : std_logic;      
        wrState, wrStateSize, wrTextSize, wrKeyStream : std_logic;          
   end record;
   type Status is record
        k_lt_textSize                                 : std_logic;       
   end record;

end GenerateKeyStream_pkg;