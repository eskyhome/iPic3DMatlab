#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni/mms64
#cd /nobackup/gianni/mms256ttNM
#cd mms256obl
#cd /home1/gianni/results

cp ~/matlab/parsek/Makefile .
cp ~/matlab/parsek/secxz_bu.m .
cp ~/matlab/parsek/converto-film .
make clean
mkdir Bfilm1
mkdir Bfilm2
mkdir Bfilm3
mkdir Bfilm4
mkdir Bfilm5

echo "starting matlab"
matlab >&! matlab.out  << EOF
results_dir=''
secxz_bu;
exit
EOF
./converto-film
