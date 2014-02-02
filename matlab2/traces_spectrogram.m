addpath 'matlab-parsek'
addpath '/home/gianni/matlab3'

close all
clear all

%results_dir='/www/shared/gianni/run99b/';
results_dir='/shared/gianni/laila11b/';
%results_dir='/shared/gianni/run100.2/';

filename=[results_dir 'settings.hdf']
Lx=hdf5read(filename,'/collective/Lx')
Ly=hdf5read(filename,'/collective/Ly')
B0x=hdf5read(filename,'/collective/B0x')
Dt=hdf5read(filename,'/collective/Dt')
XLEN=hdf5read(filename,'/topology/XLEN')
YLEN=hdf5read(filename,'/topology/YLEN')
Nprocs=hdf5read(filename,'/topology/Nprocs')
mr=abs(hdf5read(filename,'/collective/species_0/qom'))
vthr=hdf5read(filename,'/collective/species_0/uth');
mratio=abs(hdf5read(filename,'/collective/species_0/qom'))
% fir whistelr in DF
%ipx=XLEN/2+10;
%ipy=YLEN/2;
ipx=XLEN/2+1;
ipy=YLEN/2+1;
ip=(ipx-1)*YLEN+ipy;

nome=[results_dir 'VirtualSatelliteTraces' num2str(ip) '.txt']
system(['gunzip ' nome])

fid=fopen(nome);
for i=1:16
x=fscanf(fid,'%f',2); 
xp(i)=x(1)-0*Lx/2;
yp(i)=x(2)-0*Ly/2;
end


a=fscanf(fid,'%f',[14 inf])';

fclose(fid);
skip=0;
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

n0=mean(rhoi-rhoe)/2;
b0=sqrt(mean(bx.^2+by.^2+bz.^2));
wci=b0;
wci0=B0x;
wpi=1*sqrt(n0);
wpe=wpi*sqrt(mr);
wce=wci*mr;
wlh=1/sqrt(1/wce/wci+1/wpi^2);
%wpi=1 %apparently the plasma oscillations are generated elsewhere where n0=1
wRcut=.5*(wce+sqrt(wce^2+4*wpe^2));
wLcut=.5*(-wce+sqrt(wce^2+4*wpe^2));

[n m]=size(bx);
bx=reshape(bx,16,n/16);
by=reshape(by,16,n/16);
bz=reshape(bz,16,n/16);
ex=reshape(ex,16,n/16);
ey=reshape(ey,16,n/16);
ez=reshape(ez,16,n/16);
rhoe=reshape(rhoe,16,n/16);
t=linspace(0,100,n/16)*Dt*wci;
b=sqrt(bx.*bx+by.*by+bz.*bz);
epar=(ex.*bx+ey.*by+ez.*bz)./b;

Navg=20;

[exdet,dummy2]=analisi_traces(ex,b,'Ex',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[eydet,dummy2]=analisi_traces(ey,b,'Ey',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[ezdet,dummy2]=analisi_traces(ez,b,'Ez',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[dummy1,dummy2]=analisi_traces(bx,b,'Bx',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[dummy1,dummy2]=analisi_traces(by,b,'By',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[dummy1,dummy2]=analisi_traces(bz,b,'Bz',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);
[dummy1,dummy2]=analisi_traces(rhoe,b,'Rhoe',Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,0);


%dby=diff(by,1,2)/Dt;
%dby=dby(:,Navg-1:end);

faisvd=0
if(faisvd)
[u,s,v]=svd(by');
end
%plot(u(:,1)*s(1,1)*max(v(1,:)))
%title('topos')
if(faisvd)
plot(wci0*t,byavg(1,:), wci0*t,u(:,1)*s(1,1)*max(v(1,:)),'r')
title(['xsat=' num2str(xp(1)) '  ysat=',num2str(yp(1))])
end
