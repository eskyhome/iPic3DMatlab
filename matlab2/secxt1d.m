addpath 'matlab-parsek'


close all

global results_dir variable_list

if(1==1)
    clear all
    %results_dir='/home/gianni/cluster/storage/parsek/mms/results/';
    %results_dir='/home/gianni/cluster/storage/parsek/mms/prit/';
    %results_dir='/home/gianni/cluster/storage/parsek/selffeding/results/';
    %results_dir='/home/gianni/simulations/storage/parsek/selffeding/prit/';
    %results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
    results_dir='/l/users/u0052182/results/';

    %results_dir='/home/gianni/franklin/results/';
    %results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
    %results_dir='/home/gianni/simulations/storage/parsek/mms/tmp/results/';
    variable_list='E B rho J';

    parsek2D
end

wci=double(Bx0);
L=1

[nx  nt]=size(Bx);

it=nt

iy=2;

vthe=uth(2);
va=wci;

time=double(Bx_time)*wci*double(Dt);
aver=0;

recon=[];

indexf=1
%for it=1:round(nt/10):nt
for it=1:nt
    
jjy=((Jys0(1:end,it-aver:it)))/(aver+1);
bby=((By(1:end,it-aver:it)))/(aver+1);
eez=((Ez(1:end,it-aver:it)))/(aver+1);

figure(1)
subplot(1,3,1)
plot((jjy))
subplot(1,3,2)
plot((bby))
subplot(1,3,3)
plot((eez))

pause(.1)
end


jjy=((Jys0(1:end,1:end)))/(aver+1);
bby=((By(1:end,1:end)))/(aver+1);
eez=((Ez(1:end,1:end)))/(aver+1);

figure(2)
subplot(1,3,1)
pcolor(jjy) 
title('Ey')
shading interp
colorbar('northOutside')
subplot(1,3,2)
pcolor(bby)
title('B_y')
colorbar('northOutside')
shading interp
subplot(1,3,3)
pcolor(eez) 
shading interp
colorbar('northOutside')
title('Ez')
