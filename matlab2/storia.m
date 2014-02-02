addpath 'matlab-parsek'

close all

global results_dir variable_list

if(0==0)
    clear all
    %results_dir='/Users/gianni/Documents/runni/parsek/results/';
%results_dir='/home/gianni/simulations/storage/parsek/mms/tmp/results/';
%results_dir='/home/gianni/simulations/storage/parsek/selffeding/prit/';
     %results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
     results_dir='/home/gianni/simulations/storage/parsek/mms/mms512/';
 
     variable_list=' k_energy E_energy B_energy';

    parsek2D
end

[n1 n2 nt]=size(Bz)

wci=Bx0
time=double(k_nrg_time).*Dt.*wci;

figure(1)
semilogy(time,k_energy0,time,k_energy2)
title('electron kinetic')
legend('bulk','back','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['energy/elekin.png')])
saveas(gcf,['energy/elekin.fig'])
close all


figure(1)
semilogy(time,k_energy1,time,k_energy3)
title('ion kinetic')
legend('bulk','back','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['energy/ionkin.png')])
saveas(gcf,['energy/ionkin.fig'])
close all

figure(1)
Ex_nrg=squeeze(sum(squeeze(sum(Ex.^2,1)),1))/2;
Ey_nrg=squeeze(sum(squeeze(sum(Ey.^2,1)),1))/2;
Ez_nrg=squeeze(sum(squeeze(sum(Ez.^2,1)),1))/2;
semilogy(time,Ex_nrg,time,Ey_nrg,time,Ez_nrg)
title('electric')
legend('E_x','E_y','E_z','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['energy/Eene.png')])
saveas(gcf,['energy/Eene.fig'])
close all

figure(1)
Bx_nrg=squeeze(sum(squeeze(sum(Bx.^2,1)),1))/2/4/pi;
By_nrg=squeeze(sum(squeeze(sum(By.^2,1)),1))/2/4/pi;
Bz_nrg=squeeze(sum(squeeze(sum(Bz.^2,1)),1))/2/4/pi;

% for it=1:nt
%     tmp=squeeze(Bz(:,:,it));
%     Bz_nrg(it)=sum(sum(tmp.^2))/2/4/pi;
% end    
semilogy(time,Bx_nrg,time,By_nrg,time,Bz_nrg)
legend('B_x','B_y','B_z','Location','EastOutside')
title('magnetic')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['energy/Bene.png')])
saveas(gcf,['energy/Bene.fig'])
close all

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
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['energy/ene.png')])
saveas(gcf,['energy/ene.fig'])
close all
