addpath 'matlab-parsek'

close all

Lx=200;
Ly=30;
xlen=80;
ylen=12;

vthr=.045;

nproc=4
for ix=xlen/2-3:xlen/2+3
     for iy=ylen/2:ylen/2
         i=ylen*(ix)+iy;
%for i=0:3
results_dir='/home/gianni/simulations/storage/laila6/';
%results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
nome=[results_dir 'VirtualSatelliteTraces' num2str(i) '.txt'];

fid=fopen(nome);
x=fscanf(fid,'%f',4); 
xp=x(1)-Lx/2;
yp=x(2)-Ly/2;
xp2=x(3)-Lx/2;
yp2=x(4)-Ly/2;

a=fscanf(fid,'%f',[28 inf])';

fclose(fid);
skip=14;
bx=a(:,1+skip);
by=a(:,2+skip);
bz=a(:,3+skip);
ex=a(:,4+skip);
ey=a(:,5+skip);
ez=a(:,6+skip);
jxe=a(:,7+skip);
jye=a(:,8+skip);
jze=a(:,9+skip);
jxi=a(:,10+skip);
jyi=a(:,11+skip);
jzi=a(:,12+skip);
rhoe=a(:,13+skip)*4*pi;
rhoi=a(:,14+skip)*4*pi;
[n m]=size(bx);
t=linspace(0,100,n);

h=figure(i+1);
set(h,'Position' , [5 5 560 820]);
subplot(7,1,1)
%plot(t,bx,'b',t,by,'g',t,bz,'r')
plot(t,bx,'b',t,by,'r',t,bz,'g')
ylabel('B')
if (skip==0)
    title(['x=' num2str(xp) '  y=' num2str(yp) '   blue=x, red=y green=z (not GSM)' ]) 
else
    title(['x=' num2str(xp2) '  y=' num2str(yp2) '   blue=x, red=y green=z (not GSM)']) 
end
% subplot(7,1,2)
% plot(t,by)
% ylabel('By')
% subplot(7,1,3)
% plot(t,bz)
% ylabel('Bz')
subplot(7,1,2)
plot(t,ex,'b',t,ey,'r',t,ez,'g')
ylabel('E')
% subplot(7,1,5)
% plot(t,ey)
% ylabel('Ey')
% subplot(7,1,6)
% plot(t,ez)
% ylabel('Ez')
subplot(7,1,3)
plot(t,-rhoe,t,rhoi)
ylabel('\rho_e')
subplot(7,1,4)
plot(t,jxe./rhoe/vthr,'b',t,jye./rhoe/vthr,'r',t,jze./rhoe/vthr,'g')
ylabel('Ve')
subplot(7,1,5)
plot(t,jxi./rhoi/vthr,'b',t,jyi./rhoi/vthr,'r',t,jzi./rhoi/vthr,'g')
ylabel('Vi')

h=figure(i+10000);
set(h,'Position' , [694 163 340 1220]);
subplot(3,1,1)
%plot(t,bx,'b',t,by,'g',t,bz,'r')
plot(t,bx,'b',t,by,'r',t,bz,'g')
ylabel('B')
title(['x=' num2str(xp) '  y=' num2str(yp)])
subplot(3,1,2)
%plot(t,bx,'b',t,by,'g',t,bz,'r')
plot(t,ex,'b',t,ey,'r',t,ez,'g')
ylabel('E')
subplot(3,1,3)
plot(t,-rho)
ylabel('\rho_e')
print('-r300','-dpng',num2str(i+1000))
     end
end
%end
