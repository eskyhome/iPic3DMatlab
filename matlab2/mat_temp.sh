#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /www/shared/gianni/run90


cp ~/matlab/parsek/Makefile .
cp -f ~/matlab/parsek/secxz_temp.m .
make clean
mkdir Dfilm1
mkdir Dfilm2

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
secxz_temp;
exit
EOF
