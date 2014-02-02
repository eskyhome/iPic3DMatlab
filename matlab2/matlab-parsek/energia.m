whos

[n1 nt]=size(k_energy0)

wci=double(max([Bx0 By0 Bz0]))
time=double(k_nrg_time).*double(Dt).*wci;
vol=double(Dx)*double(Dy)



figure(1)
semilogy(time,k_energy0,time,k_energy2)
title('electron kinetic')
legend('bulk','back','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/elekin.png')
saveas(gcf,'energy/elekin.fig')
close all


figure(1)
semilogy(time,k_energy1,time,k_energy3)
title('ion kinetic')
legend('bulk','back','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/ionkin.png')
saveas(gcf,'energy/ionkin.fig')
close all

figure(1)
semilogy(time,k_energy0,time,k_energy1)
title('bulk species kinetic')
legend('ele','ion','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/bulkkin.png')
saveas(gcf,'energy/bulkkin.fig')
close all


figure(1)
semilogy(time,k_energy2,time,k_energy3)
title('background species kinetic')
legend('ele','ion','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/backkin.png')
saveas(gcf,'energy/backkin.fig')
close all

figure(1)
E_energy=E_energy*vol;
%Ex_nrg=squeeze(sum(squeeze(sum(Ex.^2,1)),1))/2/4/pi*vol;
%Ey_nrg=squeeze(sum(squeeze(sum(Ey.^2,1)),1))/2/4/pi*vol;
%Ez_nrg=squeeze(sum(squeeze(sum(Ez.^2,1)),1))/2/4/pi*vol;
%semilogy(time,Ex_nrg,time,Ey_nrg,time,Ez_nrg)
semilogy(time,E_energy)
title('electric')
%legend('E_x','E_y','E_z','Location','EastOutside')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/Eene.png')
saveas(gcf,'energy/Eene.fig')
close all

figure(1)
B_energy=B_energy*vol;
%Bx_nrg=squeeze(sum(squeeze(sum(Bx.^2,1)),1))/2/4/pi*vol;
%By_nrg=squeeze(sum(squeeze(sum(By.^2,1)),1))/2/4/pi*vol;
%Bz_nrg=squeeze(sum(squeeze(sum(Bz.^2,1)),1))/2/4/pi*vol;

% for it=1:nt
%     tmp=squeeze(Bz(:,:,it));
%     Bz_nrg(it)=sum(sum(tmp.^2))/2/4/pi;
% end    
%semilogy(time,Bx_nrg,time,By_nrg,time,Bz_nrg)
semilogy(time,B_energy)
%legend('B_x','B_y','B_z','Location','EastOutside')
title('magnetic')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/Bene.png')
saveas(gcf,'energy/Bene.fig')
close all

figure(2)
subplot(2,2,1)
plot(time,k_energy_total)
title('kinetic')
subplot(2,2,2)
plot(time,E_energy)
%plot(time,Ex_nrg+Ey_nrg+Ez_nrg)
title('E')
subplot(2,2,3)
plot(time,B_energy)
%plot(time,Bx_nrg+By_nrg+Bz_nrg)
title('B')
subplot(2,2,4)
%toten=Bx_nrg+By_nrg+Bz_nrg+Ex_nrg+Ey_nrg+Ez_nrg+k_energy_total;
toten=B_energy+E_energy+k_energy_total;
plot(time,(toten-toten(1)))
%plot(time,(toten-toten(1))/toten(1))
title('total (E-E(0))')
set(gcf, 'Renderer', 'zbuffer');
print('-dpng','energy/ene.png')
saveas(gcf,'energy/ene.fig')
close all
