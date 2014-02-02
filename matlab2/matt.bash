#cd /www/shared/gianni/run99b
OF=run151    
SDIR=/shared/gianni/$OF
FDIR=/www/mmsids/gianni/$OF
cd $SDIR
mkdir $FDIR

cp /home/gianni/matlab2/Makefile .
pwd

make clean
mkdir film1
mkdir film2
mkdir film3
mkdir film4
mkdir film5
mkdir film6
mkdir film7
mkdir film8
mkdir film9
mkdir film10
mkdir film11
mkdir film12
mkdir Bfilm1
mkdir Bfilm2
mkdir Bfilm3
mkdir Bfilm4
mkdir Bfilm5
mkdir Cfilm1
mkdir Cfilm2
mkdir Cfilm3
mkdir Cfilm4
mkdir Cfilm5
mkdir Cfilm6
mkdir Dfilm1
mkdir Dfilm2
mkdir Dfilm3
mkdir Dfilm4
mkdir Dfilm5
mkdir Dfilm6
mkdir Dfilm7
mkdir Dfilm8
mkdir Dfilm9
mkdir Dfilm10
mkdir Dfilm11
mkdir Efilm1
mkdir Efilm2
mkdir Efilm3
mkdir Efilm4
mkdir Efilm5
mkdir iDfilm1
mkdir iDfilm2
mkdir iDfilm3
mkdir iDfilm4
mkdir iDfilm5
mkdir iDfilm6
mkdir filmH1
mkdir filmH2
mkdir filmH3
mkdir filmH4
mkdir filmH5
mkdir filmH6
mkdir filmH7
mkdir ifilm1
mkdir ifilm2
mkdir ifilm3
mkdir ifilm4
mkdir ifilm5
mkdir ifilm6
mkdir i2film1
mkdir i2film2
mkdir i2film3
mkdir i2film4
mkdir i2film5
mkdir i2film6
mkdir Ufilm1
mkdir Ufilm2
mkdir Ufilm3
mkdir Ufilm4
mkdir Ufilm5
mkdir Ufilm6
mkdir Ufilm7
mkdir Ufilm8

rm -f *film*/*

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

%for reader_counter=24:nslicesintime
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
secxzAbu2i
secxzAbu2
secxzA;
secxzB;
secxzC;
secxzD;
secxzDi;
secxzE
secxzHall;
secxzU;
reconnection
clearvars -except contours results_dir blowup processor_name nslicesintime reader_counter info
end

%flighttplot;
exit
EOF

cp -r *film* $FDIR
cd $FDIR
/home/gianni/converto-film
