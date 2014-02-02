%addpath '/u/gianni/matlab/parsek/matlab-parsek'
%addpath '/home/gianni/matlab-parsek'
%addpath '/home/gianni/matlab/parsek/matlab-parsek'
addpath '/home/gianni/simulations/matlab/matlab-parsek'

close all

global results_dir variable_list


variable_list='B';
%variable_list='E B rho J';

parsek2D_select_pt1
parsek2D_select_pt2


wci=max([Bx0 By0 Bz0])
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

vthe=uth(1)
vthi=uth(2)
va=wci;

time=double(Bx_time)*wci*Dt;
