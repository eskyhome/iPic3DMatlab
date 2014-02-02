[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;xx=xx-max(xx(:))/2;
yy=yy/nx*Ly;yy=yy-max(yy(:))/2;

indexf=1
dnx=3;
dny=15;
for i=1:5
for j=-1:1
figure(1)
plot(time,squeeze(By(nx/2+j*dnx,ny/2+i*dny,:)/Bx0))
xlabel('\omega_{ci}t')
ylabel('B_{vert}')
title(['x/d_i = ',num2str(xx(nx/2+j*dnx,ny/2+i*dny)),'  y/d_i = ',num2str(yy(nx/2+j*dnx,ny/2+i*dny))])
print('-dpng',num2str(indexf,'%3.3i'))
close all
indexf=indexf+1
end
end

