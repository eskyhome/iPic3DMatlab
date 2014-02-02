#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni/run89

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secxz_select.m .
make clean
mkdir film1
mkdir film2
mkdir film3
mkdir film4
mkdir film5
mkdir film6

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
cycle_list='40000'
secxz_select;
exit
EOF
