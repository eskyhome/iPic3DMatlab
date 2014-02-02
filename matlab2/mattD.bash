#cd /www/shared/gianni/run99b
OF=run97.2
SDIR=/shared/gianni/$OF
FDIR=/www/mmsids/gianni/$OF
cd $SDIR
mkdir $FDIR
echo "inizio grafica $OF" |mail -s "from mmsids on $OF"  valsusa@gmail.com

cp /home/gianni/matlab2/Makefile .
pwd

make clean

for (( c=1; c<=12; c++ ))
do 
mkdir film$c
done

#mkdir Bfilm1
#mkdir Bfilm2
#mkdir Bfilm3
#mkdir Bfilm4
#mkdir Bfilm5
#mkdir Cfilm1
#mkdir Cfilm2
#mkdir Cfilm3
#mkdir Cfilm4
#mkdir Cfilm5
#mkdir Cfilm6

for (( c=1; c<=9; c++ ))
do 
mkdir Efilm$c
done

for (( c=1; c<=12; c++ ))
do 
mkdir filmH$c
done

for (( c=1; c<=8; c++ ))
do 
mkdir Ufilm$c
mkdir iUfilm$c
done

for (( c=1; c<=17; c++ ))
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
contours=1;

processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
%flight_counter=0;

% 4  per run147
% 16 per run154
% 9 for run98b
% 5 for run99b
% 13 for run101

%for reader_counter=13:13

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

%secxzA;
%secxzAbu2;
%secxzB;
%secxzC;
secxzD;
%secxzE
%secxzHall;
%secxzU;
%secxzHS;

%electrons
%species=1
%secxzF;
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
