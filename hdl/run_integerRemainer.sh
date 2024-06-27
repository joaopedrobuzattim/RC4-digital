#!/bin/bash

rm work-*.cf

ghdl  -a --std=08 generics/IntegerRemainderNbits.vhdl  
ghdl  -a --std=08 testbenchs/IntegerRemainderNbits_tb.vhdl
ghdl  -e --std=08 IntegerRemainderNbits_tb

ghdl -r   --std=08 IntegerRemainderNbits_tb --wave=IntegerRemainderNbits.ghw