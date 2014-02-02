#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlaby
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni/lhdi256

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secyzr.m .
cp ~/matlab/parsek/converto-film .
make clean
mkdir film1
mkdir film2
mkdir film3
mkdir film4
mkdir film5

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
secyzr;
exit
EOF
./converto-film
