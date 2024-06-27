#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 pkgs/Util_pkg.vhdl 
ghdl  -a --std=08 pkgs/GenerateKeyStream_pkg.vhdl 
ghdl  -a --std=08 generics/Memory.vhdl 
ghdl  -a --std=08 generics/RegisterNbits.vhdl  
ghdl  -a --std=08 generics/IntegerRemainderNbits.vhdl  
ghdl  -a --std=08 generateKeyStream/DataPath.vhdl
ghdl  -a --std=08 generateKeyStream/ControlPath.vhdl  
ghdl  -a --std=08 generateKeyStream/GenerateKeyStream.vhdl
ghdl  -a --std=08 testbenchs/GenerateKeyStream_tb.vhdl 
ghdl  -e --std=08 GenerateKeyStream_tb

ghdl -r   --std=08 GenerateKeyStream_tb --wave=GenerateKeyStream.ghw