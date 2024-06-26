#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 Util_pkg.vhd 
ghdl  -a --std=08 GenerateKeyStream_pkg.vhd 
ghdl  -a --std=08 ControlPath.vhd 
ghdl  -a --std=08 ControlPath_tb.vhd 
ghdl  -e --std=08 ControlPath_tb

ghdl -r  --std=08 ControlPath_tb --wave=ControlPath.ghw