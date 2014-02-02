addpath 'matlab-parsek'

close all

global results_dir variable_list

if(0==0)
    clear all
    %results_dir='/Users/gianni/Documents/runni/parsek/results/';
%results_dir='/home/gianni/simulations/storage/parsek/mms/tmp/results/';
%results_dir='/home/gianni/simulations/storage/parsek/selffeding/prit/';
     %results_dir='/Users/gianni/Documents/workspace/Parsek2D/results/';
     %results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
     results_dir='/l/users/u0052182/results/';
 
     variable_list=' k_energy E_energy B_energy';

    parsek2D
end

[n1 n2 nt]=size(Bz)

wci=double(Bx0)
time=double(k_nrg_time).*double(Dt).*wci;

figure(1)
subplot(3,1,1)
semilogy(time,k_energy0,'r',time,k_energy1,'b',time,k_energy_total,'y')
title('kinetic')

subplot(3,1,2)
Ex_nrg=squeeze(sum(squeeze(sum(Ex.^2,1)),1))/2*double(Dx)*double(Dy);
Ey_nrg=squeeze(sum(squeeze(sum(Ey.^2,1)),1))/2*double(Dx)*double(Dy);
Ez_nrg=squeeze(sum(squeeze(sum(Ez.^2,1)),1))/2*double(Dx)*double(Dy);
semilogy(time,Ex_nrg,time,Ey_nrg,time,Ez_nrg)
title('electric')

subplot(3,1,3)
Bx_nrg=squeeze(sum(squeeze(sum(Bx.^2,1)),1))/2/4/pi*double(Dx)*double(Dy);
By_nrg=squeeze(sum(squeeze(sum(By.^2,1)),1))/2/4/pi*double(Dx)*double(Dy);
Bz_nrg=squeeze(sum(squeeze(sum(Bz.^2,1)),1))/2/4/pi*double(Dx)*double(Dy);

% for it=1:nt
%     tmp=squeeze(Bz(:,:,it));
%     Bz_nrg(it)=sum(sum(tmp.^2))/2/4/pi;
% end    
semilogy(time,Bx_nrg,time,By_nrg,time,Bz_nrg)
legend('B_x','B_y','B_z','Location','EastOutside')
title('magnetic')

figure(2)
subplot(2,2,1)
plot(time,k_energy_total)
title('kinetic')
subplot(2,2,2)
plot(time,Ex_nrg+Ey_nrg+Ez_nrg)
title('E')
subplot(2,2,3)
plot(time,Bx_nrg+By_nrg+Bz_nrg)
title('B')
subplot(2,2,4)
toten=Bx_nrg+By_nrg+Bz_nrg+Ex_nrg+Ey_nrg+Ez_nrg+k_energy_total;
plot(time,(toten-toten(1))/toten(1))
title('total (in ppc)')
