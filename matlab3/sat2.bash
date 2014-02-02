#!/bin/bash

OF=maha5
OF2=data_redux
SAT=satX

SDIR=/shared02/gianni/$OF/$OF2
FDIR=/www/mmsids/gianni/$OF/$SAT

cd $SDIR
mkdir $FDIR

rm *.png
rm *.fig

#echo "inizio sat traces" |mail -s "from mmsids on $OF"  valsusa@gmail.com

unset DISPLAY

echo "starting matlab"
matlab -nojvm > matlab2.out  2>&1 << EOF

addpath '/home/gianni/matlab3'

detrended=0;
cycle0=000;
ISATY=1;


%sat_traces2D2_yz
sat_traces2D_yz
%sat_traces2D_xz

exit

EOF

mv *.png $FDIR
mv *.fig $FDIR
mv *.mat $FDIR

echo "fine sat traces" |mail -s "from mmsids $OF"  valsusa@gmail.com
