[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;xx=xx-max(xx(:))/2;
yy=yy/nx*Ly;yy=yy-max(yy(:))/2;

dnx=1;
dny=1;
indexf=1
for i=1:5
for j=1:3
figure(1)
plot(squeeze(flights(i,j,:)))
xlabel('\omega_{ci}t')
ylabel('B_{vert}')
title(['x/d_i = ',num2str(xx(round(nx/2)+(j-2)*dnx,round(ny/2)+i*dny)),'  y/d_i = ',num2str(yy(round(nx/2)+(j-2)*dnx,round(ny/2)+i*dny))])
print('-dpng',num2str(indexf,'%3.3i'))
close all
indexf=indexf+1
end
end

