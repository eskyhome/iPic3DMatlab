cd /www/shared/gianni/laila1/

cp ~/matlab/parsek/Makefile .
cp -f ~/matlab/parsek/readin.m .
cp -f ~/matlab/parsek/flight.m .
make clean

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
results_dir=''
readin;
flight;
exit
EOF
