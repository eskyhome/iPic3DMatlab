clear all
close all

dir='/shared02/gianni/maha2/data3/'
cycle=55000
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
xc=linspace(-45, -15, Nx);
yc=linspace(-9, 3, Ny);
x=[-15 -45]; 
y=[-9 3];


close all
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


Ay=zeros(size(Bx));
if (contours)
Ay=vecpot_uniform(xc,yc,Bx,By);
end


immagine(x,y,By*code_B,['Bn' ncycle],[-10 10],3)
hold on
contour(xc,yc,fliplr(Ay'),50,'w')
set(gcf, 'Renderer', 'zbuffer');
ylim([-5 -1])
xlim([-35 -20])
name=['Bn_combo' ncycle];
print('-depsc','-r300',[name '.eps'])
print('-dpng','-r300',[name '.png'])
%coplot_uniform(xc,yc,By'*code_B,Ay','x/d_i','y/d_i','By')
%caxis([-5 5])


