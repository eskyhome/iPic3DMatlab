addpath '/home/gianni/parsek/matlab/matlab-parsek'
results_dir=''
processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)
indexg=1;
flight_counter=0;
for reader_counter=1:nslicesintime
time_counter_list=reader_counter
%for reader_counter=1:5/2
%time_counter_list=(reader_counter-1)*2+[1 2]
readint;
%flightt;
info=hdf5info([processor_name,num2str(0),'.hdf']);
indexg=str2double(regexprep(info.GroupHierarchy.Groups(2).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
secxzA;
%secxzB;
%secxzC;
%secxzD;
indexg=indexf;
end
