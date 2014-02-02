clear all
close all

dir='/shared/gianni/drake2/part2/'
cycle=25000
ncycle=num2str(cycle);

global blowup contours
blowup=0;
contours=1;

code_E = 2060.21;
code_B = 6.87213e-06;
code_B=code_B *1e9; % to convert from Tesla to nT
code_J = 1.20082e-05;
code_J = code_J*1e9; % to convert to nA/m^2
code_V = 2.99792e+08;
code_V=code_V/1e3; %to convert to Km/s
code_T = 1.50326e-10;
code_n = 0.25;
e=1.6e-19;


addpath '/home/gianni/matlab2/matlab-parsek'
filename=[dir 'settings.hdf'];
Lx=hdf5read(filename,'/collective/Lx'); 
Ly=hdf5read(filename,'/collective/Ly');
Nx=hdf5read(filename,'/collective/Nxc'); 
Ny=hdf5read(filename,'/collective/Nyc');
x=[0 Lx]; 
y=[0 Ly];
xn=linspace(0,Lx,Nx);
yn=linspace(0,Ly,Ny);




file=[dir 'B_x_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Bx=fread(fid,'real*8');
fclose(fid);
Bx=reshape(Bx,Nx,Ny);

file=[dir 'B_y_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
By=fread(fid,'real*8');
fclose(fid);
By=reshape(By,Nx,Ny);

file=[dir 'B_z_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Bz=fread(fid,'real*8');
fclose(fid);
Bz=reshape(Bz,Nx,Ny);

b2=Bx.^2+By.^2+Bz.^2;


file=[dir 'VNFi_x_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
VNFix=fread(fid,'real*8');
fclose(fid);
VNFix=reshape(VNFix,Nx,Ny);

file=[dir 'VNFi_y_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
VNFiy=fread(fid,'real*8');
fclose(fid);
VNFiy=reshape(VNFiy,Nx,Ny);

file=[dir 'VNFi_z_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
VNFiz=fread(fid,'real*8');
fclose(fid);
VNFiz=reshape(VNFiz,Nx,Ny);

VNFi_unsm=sqrt(VNFix.^2+VNFiy.^2+VNFiz.^2);
Nsm=0
VNFi=smooth(VNFi_unsm,Nsm);

file=[dir 'Pi_eps_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
EPS=fread(fid,'real*8');
fclose(fid);
EPS=reshape(EPS,Nx,Ny);


file=[dir 'Pi_par_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Ppar=fread(fid,'real*8');
fclose(fid);
Ppar=reshape(Ppar,Nx,Ny);

file=[dir 'Pi_per1_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Pper1=fread(fid,'real*8');
fclose(fid);
Pper1=reshape(Pper1,Nx,Ny);

file=[dir 'Pi_per2_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Pper2=fread(fid,'real*8');
fclose(fid);
Pper2=reshape(Pper2,Nx,Ny);

eps2=1-4*pi*(Ppar-sqrt(Pper1.*Pper2))./b2;

immagine_dir(x,y,VNFi,['' ncycle],[0 .1],0)

xlim([150 400]) 
ylim([50 150])
name='VNFi'
print('-dpng','-r300',[name '.png'])


xlim([220 300]) 
ylim([102-15 102+15])
name='VNFi'
print('-dpng','-r300',[name '_bu.png'])


figure
% First index is x 


Nplot=2400:200:2800;

plot(yn,VNFi(Nplot,:))
%title(['x=' num2str(xn(Nplot))],'fontsize',[14])
xlim([50 150]) 
legend(num2str(round(xn(Nplot)')))
set(gca,'fontsize',[14])
xlabel('y/d_i','fontsize',[14])
ylabel('(u_i-u_{ExB})/c','fontsize',[14])
print('-depsc','-painters',[name '_cuts.eps'])
%hold on
%contour(xc,yc,fliplr(Ay'),50,'w')


figure

immagine_dir(x,y,EPS,['\epsilon' ncycle],[-.5 1.5],0)

xlim([150 400]) 
ylim([50 150])
name='EPS'
print('-dpng','-r300',[name '.png'])

immagine_dir(x,y,eps2,['\epsilon' ncycle],[-.5 1.5],0)

xlim([150 400]) 
ylim([50 150])
name='eps2'
print('-dpng','-r300',[name '.png'])


return

set(gcf, 'Renderer', 'zbuffer');
ylim([-5 -1])
xlim([-35 -20])
name=['Bn_combo' ncycle];
print('-depsc','-r300',[name '.eps'])
print('-dpng','-r300',[name '.png'])
%coplot_uniform(xc,yc,By'*code_B,Ay','x/d_i','y/d_i','By')
%caxis([-5 5])


