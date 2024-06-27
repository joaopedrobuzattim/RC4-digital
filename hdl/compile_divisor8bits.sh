#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 Division8bit.vhd  
ghdl  -a --std=08 Division8bit_tb.vhd  
ghdl  -e --std=08 Division8bit_tb

ghdl -r   --std=08 Division8bit_tb --wave=Division8bit_tb.ghw