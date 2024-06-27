#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 generics/IntegerRemainderNbits.vhd  
ghdl  -a --std=08 testbenchs/IntegerRemainderNbits_tb.vhd
ghdl  -e --std=08 IntegerRemainderNbits_tb

ghdl -r   --std=08 IntegerRemainderNbits_tb --wave=IntegerRemainderNbits.ghw