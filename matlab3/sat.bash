#!/bin/bash

OF=tred54.2
SAT=sat_vsy_whistlerDF

SDIR=/shared/gianni/$OF
FDIR=/www/mmsids/gianni/$OF/$SAT

cd $SDIR
mkdir $FDIR

rm *.png
rm *.fig

echo "inizio sat traces" |mail -s "from mmsids on $OF"  valsusa@gmail.com

unset DISPLAY

echo "starting matlab"
#matlab 
matlab > matlab_sat.out  2>&1 << EOF

addpath '/home/gianni/matlab3'

detrended=0;
cycle0=000; 
ISATY=1; %not used in 3D

sat_traces_xz
%sat_traces_yz
%sat_traces2D_yz
%sat_traces2D_xz

exit

EOF

cp *.png $FDIR
cp *.fig $FDIR
cp *.mat $FDIR

echo "fine sat traces" |mail -s "from mmsids $OF"  valsusa@gmail.com
