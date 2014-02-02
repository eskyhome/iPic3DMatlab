#PBS -l walltime=24:00:00
#PBS -l nodes=1
#PBS -l pmem=32000mb
#PBS -l mem=32000mb

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a


cd ~/ipic3D1/matlab/


unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
driver3D
exit
EOF

