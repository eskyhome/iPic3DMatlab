
aver=0;

recon=[];
tslice=[];

indexf=indexg
    
bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);
eex=squeeze(sum(Ex(1:end,1:end,it-aver:it),3))/(aver+1);
eey=squeeze(sum(Ey(1:end,1:end,it-aver:it),3))/(aver+1);
eez=squeeze(sum(Ez(1:end,1:end,it-aver:it),3))/(aver+1);
jsx0=squeeze(sum(Jxs0(1:end,1:end,it-aver:it),3))/(aver+1);
jsy0=squeeze(sum(Jys0(1:end,1:end,it-aver:it),3))/(aver+1);
jsz0=squeeze(sum(Jzs0(1:end,1:end,it-aver:it),3))/(aver+1);
jsxb=squeeze(sum(Jxs2(1:end,1:end,it-aver:it),3))/(aver+1);
jsyb=squeeze(sum(Jys2(1:end,1:end,it-aver:it),3))/(aver+1);
jszb=squeeze(sum(Jzs2(1:end,1:end,it-aver:it),3))/(aver+1);
rrho=squeeze(sum(rhos0(1:end,1:end,it-aver:it),3))/(aver+1);
rrhob=squeeze(sum(rhos2(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=((jsx0+jsxb).*bbx+(jsy0+jsyb).*bby+(jsz0+jszb).*bbz)./((rrho+rrhob).*bbb);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

vx=(jsx0+jsxb)./(rrho+rrhob);
vy=(jsy0+jsyb)./(rrho+rrhob);
vz=(jsz0+jszb)./(rrho+rrhob);
vexbx=(eey.*bbz-eez.*bby)./bbb.^2;
vexby=(eez.*bbx-eex.*bbz)./bbb.^2;
vexbz=(eex.*bby-eey.*bbx)./bbb.^2;

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,vx,vy);
strfexb=vecpot(xx,yy,vexbx,vexby);

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,bbz,ay,'x/d_i','y/d_i',['B_{z}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film1/' num2str(indexf,'%8.8i')])
close all

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi_{e}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film2/' num2str(indexf,'%8.8i')])
close all


disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vz,ay,'x/d_i','y/d_i',['V_z(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film3/' num2str(indexf,'%8.8i')])
close all


return
