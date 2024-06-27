#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 pkgs/Util_pkg.vhd 
ghdl  -a --std=08 pkgs/GenerateKeyStream_pkg.vhd 
ghdl  -a --std=08 generics/Memory.vhd 
ghdl  -a --std=08 generics/RegisterNbits.vhd  
ghdl  -a --std=08 generics/IntegerRemainderNbits.vhd  
ghdl  -a --std=08 generateKeyStream/DataPath.vhd
ghdl  -a --std=08 generateKeyStream/ControlPath.vhd  
ghdl  -a --std=08 generateKeyStream/GenerateKeyStream.vhd
ghdl  -a --std=08 testbenchs/GenerateKeyStream_tb.vhd 
ghdl  -e --std=08 GenerateKeyStream_tb

ghdl -r   --std=08 GenerateKeyStream_tb --wave=GenerateKeyStream.ghw