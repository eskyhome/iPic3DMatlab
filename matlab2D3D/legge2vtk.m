global blowup contours
blowup=0;
contours=0;

dir='/shared02/gianni/maha2/data1/'
cycle=19000
ncycle=num2str(cycle)

code_E = 2060.21;
code_B = 6.87213e-06;
code_B=code_B *1e9; % to convert from Tesla to nT
code_J = 1.20082e-05;
code_J = code_J*1e9; % to convert to nA/m^2
code_V = 2.99792e+08;
code_V=code_V/1e3; %to convert to Km/s
code_T = 1.50326e-10;
code_n = 0.25;


addpath '/home/gianni/matlab2/matlab-parsek'
filename=[ dir 'settings.hdf'];
Lx=hdf5read(filename,'/collective/Lx'); 
Ly=hdf5read(filename,'/collective/Ly');
Nx=hdf5read(filename,'/collective/Nxc'); 
Ny=hdf5read(filename,'/collective/Nyc');
Dx=hdf5read(filename,'/collective/Dx'); 
Dy=hdf5read(filename,'/collective/Dy');
Dz=hdf5read(filename,'/collective/Dz');
xc=linspace(0, Lx, Nx);
yc=linspace(0, Ly, Ny);
x=[-15 -45]; 
y=[-9 3];

file=[dir 'Je_x_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Jex=fread(fid,'real*8');
fclose(fid);
Jex=reshape(Jex,Nx,Ny);

file=[dir 'Je_y_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Jey=fread(fid,'real*8');
fclose(fid);
Jey=reshape(Jey,Nx,Ny);


file=[dir 'Je_z_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Jez=fread(fid,'real*8');
fclose(fid);
Jez=reshape(Jez,Nx,Ny);

file=[dir 'rho_0_cycle' ncycle '.gda'];
fid= fopen(file,'rb');
Ne=fread(fid,'real*8');
fclose(fid);
Ne=reshape(Ne,Nx,Ny);

Vex=Jex./Ne;
Vey=Jey./Ne;
Vez=Jez./Ne;
Nsm=15;
Jexsm=smooth(Jex,Nsm);
Jeysm=smooth(Jey,Nsm);
Jezsm=smooth(Jez,Nsm);
Vexsm=smooth(Vex,Nsm);
Veysm=smooth(Vey,Nsm);
Vezsm=smooth(Vez,Nsm);

savevtkvector(Vexsm, Veysm, Vezsm, 'Vsmooth.vtk','Vsmooth',Dx,Dy,Dz)
savevtkvector(Jexsm, Jeysm, Jezsm, 'Jsmooth.vtk','Jsmooth',Dx,Dy,Dz)
