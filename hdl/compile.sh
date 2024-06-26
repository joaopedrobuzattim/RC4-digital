#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 Util_pkg.vhd 
ghdl  -a --std=08 Memory.vhd 
ghdl  -a --std=08 GenerateKeyStream_pkg.vhd 
ghdl  -a --std=08 DataPath.vhd 
ghdl  -a --std=08 GenerateKeyStream.vhd
ghdl  -a --std=08 RegisterNbits.vhd  
ghdl  -a --std=08 GenerateKeyStream_tb.vhd 
ghdl  -e --std=08 GenerateKeyStream_tb

ghdl -r  --std=08 GenerateKeyStream_tb --wave=GenerateKeyStream.ghw