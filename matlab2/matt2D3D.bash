#cd /www/shared/gianni/run99b
OF=lailaO1/data1
SDIR=/shared02/gianni/$OF
FDIR=/www/mmsids/gianni/$OF
cd $SDIR
mkdir -r $FDIR
echo "inizio grafica $OF" |mail -s "from mmsids on $OF"  valsusa@gmail.com

cp /home/gianni/matlab2/Makefile .
pwd

make clean

for (( c=1; c<=12; c++ ))
do 
mkdir film$c
done


for (( c=1; c<=9; c++ ))
do 
mkdir Efilm$c
done

for (( c=1; c<=8; c++ ))
do 
mkdir Ufilm$c
mkdir iUfilm$c
done

for (( c=1; c<=20; c++ ))
do 
mkdir Dfilm$c
mkdir iDfilm$c
done

for (( c=1; c<=6; c++ ))
do 
mkdir HSfilm$c
done

for (( c=1; c<=9; c++ ))
do 
mkdir ifilm$c
done

for (( c=1; c<=13; c++ ))
do 
mkdir filmH$c
done

for (( c=1; c<=13; c++ ))
do 
mkdir 1Ffilm$c
mkdir 2Ffilm$c
done

for (( c=10; c<=15; c++ ))
do 
mkdir Ffilm$c
done


unset DISPLAY

echo starting matlab
/usr/local/matlab/bin/matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab2/matlab-parsek'
global contours code_version
results_dir=''

blowup=1; %blowup=1 does it, 0 does not do it.
contours=1;

code_version=1;

processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
%flight_counter=0;

% 4  per run147
% 16 per run154
% 9 for run98b
% 5 for run99b
% 13 for run101

for reader_counter=nslicesintime:nslicesintime


%for reader_counter=1:nslicesintime

%for reader_counter=nslicetime-1:nslicesintime
time_counter_list=reader_counter
%for reader_counter=1:5/2
%time_counter_list=(reader_counter-1)*2+[1 2]
%indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/energy/electric/cycle_',''))
readint;
info=hdf5info([processor_name,num2str(0),'.hdf']);
indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
%flightt;

secxzA;
%secxzAbu2;

%The following are obsolete
%secxzB;
%secxzC;

% Pressure tensor analysis
%secxzD;

%Compute Eper and Epar
%secxzE

% Compute fields
%secxzHall;

% Compute flows
%secxzU;

%Compute particle eneregy flows
%secxzHS;

% Computes fluctuations and energetics
%electrons
species=1
%secxzF;
%ions
species=2
%secxzF;

% Ion diagnostics
%secxzAi
%secxzDi;
%secxzUi;

reconnection
clearvars -except contours results_dir blowup processor_name nslicesintime reader_counter info
end

%flighttplot;
exit
EOF

cp -R -r *film* $FDIR

echo "finito grafica $OF" |mail -s "from mmsids on $OF"  valsusa@gmail.com
cd $FDIR
/home/gianni/converto-film $FDIR
