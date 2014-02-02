%addpath '/u/gianni/matlab/parsek/matlab-parsek'
%addpath '/home/gianni/matlab-parsek'
%addpath '/home/gianni/matlab/parsek/matlab-parsek'
addpath '/home/gianni/Desktop/parsek/matlab-parsek'

close all

global results_dir variable_list


variable_list='E B rho J pressure';
%variable_list='E B rho J';

parsek2D

skippa=1
if(skippa)
%Correct pressure for average drift
pxx=(pxx0+pxx2-Jxs0.^2-Jxs2.^2)./(rhos0+rhos2);
pxy=(pxy0+pxy2-Jxs0.*Jys0-Jxs2.*Jys2)./(rhos0+rhos2); 
pxz=(pxz0+pxz2-Jxs0.*Jzs0-Jxs2.*Jzs2)./(rhos0+rhos2); 

pyy=(pyy0+pyy2-Jys0.^2-Jys2.^2)./(rhos0+rhos2);
pyz=(pyz0+pyz2-Jys0.*Jzs0-Jys2.*Jzs2)./(rhos0+rhos2); 

pzz=(pzz0+pzz2-Jzs0.^2-Jzs2.^2)./(rhos0+rhos2);
end

wci=Bx0
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

vthe=uth(1)
va=wci;

time=double(Bx_time)*wci*Dt;
