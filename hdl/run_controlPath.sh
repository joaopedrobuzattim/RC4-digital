#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 pkgs/Util_pkg.vhdl 
ghdl  -a --std=08 pkgs/GenerateKeyStream_pkg.vhdl 
ghdl  -a --std=08 generateKeyStream/ControlPath.vhdl 
ghdl  -a --std=08 testbenchs/ControlPath_tb.vhdl 
ghdl  -e --std=08 ControlPath_tb

ghdl -r  --std=08 ControlPath_tb --wave=ControlPath.ghw