fid = fopen('B_cut_xz_cycle50.vtk');
A = fscanf(fid,'%s',5);
A = fscanf(fid,'%s',7);
A = fscanf(fid,'%s',1);
NX = fscanf(fid, '%d',1);
NY = fscanf(fid, '%d',1);
NZ = fscanf(fid, '%d',1);
A = fscanf(fid,'%s',1);
OX = fscanf(fid, '%d',1);
OY = fscanf(fid, '%d',1);
OZ = fscanf(fid, '%d',1);
A = fscanf(fid,'%s',1);
DX = fscanf(fid, '%f',1);
DY = fscanf(fid, '%f',1);
DZ = fscanf(fid, '%f',1);
A = fscanf(fid,'%s',1);
NP = fscanf(fid, '%d',1);
A = fscanf(fid,'%s',3);
V=fscanf(fid,'%f',[3, NP]);
VX=reshape(V(1,:),NX,NY);
VY=reshape(V(2,:),NX,NY);
VZ=reshape(V(3,:),NX,NY);
fclose(fid);

pcolor(VZ)