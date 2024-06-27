#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 pkgs/Util_pkg.vhd 
ghdl  -a --std=08 pkgs/GenerateKeyStream_pkg.vhd 
ghdl  -a --std=08 generateKeyStream/ControlPath.vhd 
ghdl  -a --std=08 testbenchs/ControlPath_tb.vhd 
ghdl  -e --std=08 ControlPath_tb

ghdl -r  --std=08 ControlPath_tb --wave=ControlPath.ghw