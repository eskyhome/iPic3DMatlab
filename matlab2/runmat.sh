#!/bin/sh
clear
unset DISPLAY 
cd matlab/parsek
make clean
matlab > matlab.out 2>&1 << EOF
results_dir='/data/n/u0052182/mms1836v2/';
secxzr;
exit
./converto-film
EOF
