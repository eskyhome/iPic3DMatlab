#PBS -l walltime=4:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni

cd mms256obl

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secxz_nbr.m .
#cp ~/matlab/parsek/secxz2r.m .
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

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
secxz_nbr;
exit
EOF
./converto-film
