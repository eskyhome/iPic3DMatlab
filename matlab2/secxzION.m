
aver=0;

recon=[];
tslice=[];

indexf=1
%for it=1:round(nt/10):nt
for it=1:nt
    
bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);
eex=squeeze(sum(Ex(1:end,1:end,it-aver:it),3))/(aver+1);
eey=squeeze(sum(Ey(1:end,1:end,it-aver:it),3))/(aver+1);
eez=squeeze(sum(Ez(1:end,1:end,it-aver:it),3))/(aver+1);
jsx1=squeeze(sum(Jxs1(1:end,1:end,it-aver:it),3))/(aver+1);
jsy1=squeeze(sum(Jys1(1:end,1:end,it-aver:it),3))/(aver+1);
jsz1=squeeze(sum(Jzs1(1:end,1:end,it-aver:it),3))/(aver+1);
jsxb=squeeze(sum(Jxs3(1:end,1:end,it-aver:it),3))/(aver+1);
jsyb=squeeze(sum(Jys3(1:end,1:end,it-aver:it),3))/(aver+1);
jszb=squeeze(sum(Jzs3(1:end,1:end,it-aver:it),3))/(aver+1);
rrho=squeeze(sum(rhos1(1:end,1:end,it-aver:it),3))/(aver+1);
rrhob=squeeze(sum(rhos3(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=((jsx1+jsxb).*bbx+(jsy1+jsyb).*bby+(jsz1+jszb).*bbz)./((rrho+rrhob).*bbb);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx1)./(rrhob+rrho),(jsy1+jsyb)./(rrhob+rrho));

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz1+jszb,ay,'x/d_i','y/d_i',['J_{zi}(\omega_{ci}t=' num2str(time(it)) ')'])
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Ifilm1/' num2str(indexf,'%3.3i')])

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,(rrho+rrhob)*4*pi,ay,'x/d_i','y/d_i',['\rho_{i}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Ifilm2/' num2str(indexf,'%3.3i')])


disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/vthe,ay,'x/d_i','y/d_i',['U_{i||}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Ifilm3/' num2str(indexf,'%3.3i')])

disp('f4')
h=figure(4);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,rrhob,ay,'x/d_i','y/d_i',['\rho_b(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Ifilm4/' num2str(indexf,'%3.3i')])

disp('f5')
h=figure(5);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\rho_b(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Ifilm5/' num2str(indexf,'%3.3i')])


indexf=indexf+1

close all
end
