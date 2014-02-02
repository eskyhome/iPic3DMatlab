#!/bin/bash
#cd /www/shared/gianni/run99b
OF=run98b
SDIR=/www/shared/gianni/$OF
FDIR=/www/mmsids/gianni/$OF
cd $SDIR
mkdir $FDIR
echo "inizio grafica $OF" |mail -s "from mmsids on $OF"  valsusa@gmail.com

cp /home/gianni/matlab2/Makefile .
pwd

make clean

for (( c=1; c<=12; c++ ))
do 
mkdir filmH$c
done

for (( c=1; c<=13; c++ ))
do 
mkdir 1Ffilm$c
mkdir 2Ffilm$c
done

mkdir Ffilm10
mkdir Ffilm11
mkdir Ffilm12
mkdir Ffilm13
mkdir Ffilm14
mkdir Ffilm15



unset DISPLAY

echo starting matlab
matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab2/matlab-parsek'
global contours
results_dir=''

blowup=1; %blowup=1 does it, 0 does not do it.
contours=0;

processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
%flight_counter=0;

%for reader_counter=4:4
for reader_counter=1:nslicesintime

%for reader_counter=nslicetime-1:nslicesintime
time_counter_list=reader_counter
%for reader_counter=1:5/2
%time_counter_list=(reader_counter-1)*2+[1 2]
indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/energy/electric/cycle_',''))
readint;
info=hdf5info([processor_name,num2str(0),'.hdf']);
%indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
%flightt;

%secxzAbu2
%secxzA;
%secxzB;
%secxzC;
%secxzD;
%secxzE
%secxzHall;
%secxzU;
%secxzHS;

%electrons
%species=1
secxzF;
%ions
%species=2
%secxzF;

%secxzAi
%secxzDi;
%secxzUi;

%reconnection
clearvars -except contours results_dir blowup processor_name nslicesintime reader_counter info
end

%flighttplot;
exit
EOF

cp -r *film* $FDIR
echo "finito grafica $OF" |mail -s "from mmsids on $OF"  valsusa@gmail.com
cd $FDIR
/home/gianni/converto-film $FDIR
