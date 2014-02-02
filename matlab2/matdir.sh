cd /data/leuven/300/vsc30007

cd mms256Bhr

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secxzr.m .
cp ~/matlab/parsek/secxz2r.m .
cp ~/matlab/parsek/converto-film .
make clean
mkdir film1
mkdir film2
mkdir film3
mkdir film4
mkdir film5
mkdir film6
mkdir film7
mkdir film8
mkdir film9
mkdir film10
mkdir film11
mkdir film12

module load matlab
unset DISPLAY

echo "starting matlab"
matlab > matlab.out 2>&1 << EOF
%results_dir='/data/leuven/300/vsc30007/mms256Bhr/';
secxzr;
secxz2r;
exit
EOF
./converto-film
