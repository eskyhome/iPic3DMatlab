aver=0;

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

ymax=max(yy(:));
xmax=max(xx(:));
yrange=[ymax/2-ymax/8 ymax/2+ymax/8];
xrange=[xmax/2-xmax/8 xmax/2+xmax/8];

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz0+jszb,ay,'x/d_i','y/d_i',['J_{ze}(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film7/' num2str(indexf,'%8.8i')])

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,(rrho+rrhob)*4*pi,ay,'x/d_i','y/d_i',['\rho_{e}(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film8/' num2str(indexf,'%8.8i')])


disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/vthe,ay,'x/d_i','y/d_i',['U_{e||}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
%coplot(xx,yy,jsz0./rrho,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%F3(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film9/' num2str(indexf,'%8.8i')])

disp('f4')
h=figure(4);
set(h,'Position' , [565 550 560 420]);
coplot(xx,yy,epar,ay,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
%F4(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film10/' num2str(indexf,'%8.8i')])

% h=figure(4);
% set(h,'Position' , [565 550 560 420]);
% coplot(xx,yy,jsx0./rrho,ay,'x/d_i','y/d_i',['V_{ex}(\omega_{ci}t=' num2str(time(it)) ')'])
% F4(indexf)=getframe(gcf);

disp('f5')
h=figure(5);
set(h,'Position' , [1125 550 560 420]);
%coplot(xx,yy,eez,ay,'x/d_i','y/d_i',['E_z(\omega_{ci}t=' num2str(time(it)) ')'])
coplot(xx,yy,rrhob,ay,'x/d_i','y/d_i',['\rho_b(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
%F5(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film11/' num2str(indexf,'%8.8i')])

disp('f6')
h=figure(6);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,(jsx0+jsxb)./(rrho+rrhob)/vthe,ay,'x/d_i','y/d_i',['V_{ex}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
ylim(yrange)
xlim(xrange)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film12/' num2str(indexf,'%8.8i')])

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
