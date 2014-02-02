#!/bin/bash
OF="maha2/data1"
SDIR="/shared02/gianni/"$OF
FDIR="/www/mmsids/gianni/"$OF
cd $SDIR
mkdir -p $FDIR

cp /home/gianni/matlab3/Makefile .
pwd

make clean

mkdir filmXY
mkdir filmXZ
mkdir filmYZ

rm film*/*

unset DISPLAY

echo "starting matlab"
matlab > matlab.out  2>&1 << EOF
addpath '/home/gianni/matlab3'
addpath '/home/gianni/matlab2/matlab-parsek'
results_dir=''

% to save .fig files besides .png set fgs to 1
figs=0;

% if there is a background put 1
background=1;

processor_name=[results_dir 'proc'];
info=hdf5info([processor_name,num2str(0),'.hdf']);
nslicesintime=size(info.GroupHierarchy.Groups(1).Groups(1).Datasets,2)

ig=0;
for reader_counter=1:nslicesintime
        time_counter_list=reader_counter
        parsek3D_select_single
        info=hdf5info([processor_name,num2str(0),'.hdf']);
        ig=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/fields/Bx/cycle_',''))
if(isnan(ig))
        ig=str2double(regexprep(info.GroupHierarchy.Groups(1).Groups(1).Datasets(reader_counter).Name,'/energy/electric/cycle_',''))
end
ig=double(ig)
%wci=Bx0
wci=.0097
vthe=uth(1)
vthi=uth(2)
va=wci;
        sec3Dxy
        sec3Dxz
        sec3Dyz
end


exit

EOF

chmod u+x film*
cp -r *film* $FDIR
cd $FDIR
/home/gianni/converto-film3
