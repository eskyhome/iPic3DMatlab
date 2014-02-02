aver=0;

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt

campi_ion

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

ymax=max(yy(:));
xmax=max(xx(:));

limits

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz0+jszb,ay,'x/d_i','y/d_i',['J_{zi}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['i2film1/' num2str(indexf,'%8.8i')])

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,(rrho+rrhob)*4*pi,ay,'x/d_i','y/d_i',['\rho_{i}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['i2film2/' num2str(indexf,'%8.8i')])


disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/vthe,ay,'x/d_i','y/d_i',['U_{i||}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%coplot(xx,yy,jsz0./rrho,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%F3(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['i2film3/' num2str(indexf,'%8.8i')])


% h=figure(4);
% set(h,'Position' , [565 550 560 420]);
% coplot(xx,yy,jsx0./rrho,ay,'x/d_i','y/d_i',['V_{ex}(\omega_{ci}t=' num2str(time(it)) ')'])
% F4(indexf)=getframe(gcf);

h=figure(5);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,(jsx0+jsxb)./(rrho+rrhob)/vthe,ay,'x/d_i','y/d_i',['V_{ix}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['i2film4/' num2str(indexf,'%8.8i')])

disp('f7')
h=figure(7);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,(jsy0+jsyb)./(rrho+rrhob)/vthe,ay,'x/d_i','y/d_i',['V_{iy}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['i2film5/' num2str(indexf,'%8.8i')])

% surf(xx,yy-max(yy(:))/2,eez,'edgecolor','none','facecolor','blue')
% lighting phong
% shading interp
% camlight(0,90) % luce dall'alto
% view(2) %visione dall'alto
% axis tight

indexf=indexf+1

close all
end

return
