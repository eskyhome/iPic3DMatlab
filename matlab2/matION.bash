cd /www/shared/gianni/run94

cp ~/matlab/parsek/Makefile .
cp -f ~/matlab/parsek/readin.m .
cp -f ~/matlab/parsek/secxzION.m .
make clean
mkdir Ifilm1
mkdir Ifilm2
mkdir Ifilm3
mkdir Ifilm4
mkdir Ifilm5

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
results_dir=''
readin;
secxzION;
exit
EOF
