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
cp -f ~/matlab/parsek/secxz_holes.m .
make clean
mkdir Cfilm1
mkdir Cfilm2
mkdir Cfilm3
mkdir Cfilm4
mkdir Cfilm5
mkdir Cfilm6

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
secxz_holes;
exit
EOF
