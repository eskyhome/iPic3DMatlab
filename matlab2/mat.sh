#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni/mms1836hdt
#cd /nobackup/gianni/mms256ttNM
#cd mms256obl
#cd /home1/gianni/results

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secxzr.m .
cp ~/matlab/parsek/secxzbur.m .
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
secxzr;
secxzbur;
exit
EOF
./converto-film
