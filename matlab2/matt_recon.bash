#cd /www/shared/gianni/run99b
OF="run157.3"
SDIR="/shared/gianni/"$OF
FDIR="/www/mmsids/gianni/"$OF
cd $SDIR
mkdir $FDIR

cp /home/gianni/matlab2/Makefile .
pwd

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab2/matlab-parsek'
global contours
results_dir=''

blowup=1;
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
readint_rec;
info=hdf5info([processor_name,num2str(0),'.hdf']);
reconnection
end

%flighttplot;
exit
EOF

cp -r *film* $FDIR
cd $FDIR
/home/gianni/converto-film
