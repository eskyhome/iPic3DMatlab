#PBS -l walltime=24:00:00
#PBS -l nodes=1

#PBS -N matlab
#PBS -j oe -k eo

echo Start: host `hostname`, date `date`

module load  mw/matlab.2007a

cd /nobackup/gianni/laila11

cp ~/matlab/Makefile .

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
mkdir filmH1
mkdir filmH2
mkdir filmH3
mkdir filmH4
mkdir filmH5
mkdir filmH6

unset DISPLAY

echo "starting matlab"
matlab >&! matlab.out  << EOF
addpath '/home1/gianni/matlab/matlab-parsek'
results_dir=''
processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
%flight_counter=0;
for reader_counter=1:nslicesintime
time_counter_list=reader_counter
%for reader_counter=1:5/2
%time_counter_list=(reader_counter-1)*2+[1 2]
indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/energy/electric/cycle_',''))
readint;
info=hdf5info([processor_name,num2str(0),'.hdf']);
%indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
%flightt;
secxzA;
secxzB;
secxzC;
secxzD;
secxzHall;
end
exit
EOF
