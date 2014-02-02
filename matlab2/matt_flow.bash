cd /www/shared/gianni/run79

cp /home/gianni/matlab/Makefile .

make clean
mkdir film1
mkdir film2
mkdir film3

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab/matlab-parsek'
results_dir=''
processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
for reader_counter=1:nslicesintime
time_counter_list=reader_counter;
readint;
info=hdf5info([processor_name,num2str(0),'.hdf']);
%indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
indexg=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/energy/electric/cycle_',''))
secxz_flow;
end

exit
EOF
