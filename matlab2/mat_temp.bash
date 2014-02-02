cd /www/shared/gianni/run91

cp ~/matlab/parsek/Makefile .
cp -f ~/matlab/parsek/secxz_temp.m .
make clean
mkdir Dfilm1
mkdir Dfilm2
mkdir Dfilm3

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
results_dir=''
secxz_temp;
exit
EOF
