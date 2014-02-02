OF="dw1"
SDIR="/shared/gianni/"$OF
FDIR="/www/mmsids/gianni/"$OF
cd $SDIR
mkdir $FDIR

cp /home/gianni/matlab2/Makefile .
pwd

make clean
mkdir energy

rm -f *film*/*

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab2/matlab-parsek'

global results_dir variable_list

results_dir=''
variable_list=' k_energy e_energy b_energy';
parsek2D
energia
exit
EOF

cp -r energy $FDIR
cd $FDIR
