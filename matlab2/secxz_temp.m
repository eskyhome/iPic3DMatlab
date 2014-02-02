addpath '/u/gianni/matlab/parsek/matlab-parsek'
addpath '/home/gianni/matlab-parsek'
addpath '/home/gianni/matlab/parsek/matlab-parsek'

close all

global results_dir variable_list

vai=1;

if(vai)
    %clear all
    variable_list='E B rho J pressure';

    parsek2D
end

wci=Bx0
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

vthe=uth(1);
va=wci;

time=double(Bx_time)*wci*Dt;

%Correct for average drift
pxx=(pxx0+pxx2-Jxs0.^2-Jxs2.^2)./(rhos0+rhos2);
pxy=(pxy0+pxy2-Jxs0.*Jys0-Jxs2.*Jys2)./(rhos0+rhos2); 
pxz=(pxz0+pxz2-Jxs0.*Jzs0-Jxs2.*Jzs2)./(rhos0+rhos2); 

pyy=(pyy0+pyy2-Jys0.^2-Jys2.^2)./(rhos0+rhos2);
pyz=(pyz0+pyz2-Jys0.*Jzs0-Jys2.*Jzs2)./(rhos0+rhos2); 

pzz=(pzz0+pzz2-Jzs0.^2-Jzs2.^2)./(rhos0+rhos2);


aver=0;


indexf=1
%for it=1:round(nt/10):nt
for it=1:nt
    
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


pXX=squeeze(sum(pxx(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;
pXY=squeeze(sum(pxy(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;
pXZ=squeeze(sum(pxz(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;
pYY=squeeze(sum(pyy(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;
pYZ=squeeze(sum(pyz(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;
pZZ=squeeze(sum(pzz(1:end,1:end,it-aver:it),3))/(aver+1)/vthe^2;

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=((jsx0+jsxb).*bbx+(jsy0+jsyb).*bby+(jsz0+jszb).*bbz)./((rrho+rrhob).*bbb);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

ppar=(bbx.*pXX.*bbx+2*bbx.*pXY.*bby+2*bbx.*pXZ.*bbz);
ppar=ppar+(bby.*pYY.*bby+2*bby.*pYZ.*bbz);
ppar=ppar+(bbz.*pZZ.*bbz);
ppar=ppar./bbb.^2;
vthpar=sqrt(abs(ppar));

pper=(bby.*pXX.*bby-2*bby.*pXY.*bbx);
pper=pper+(bbx.*pYY.*bbx);
pper=pper./(bbx.^2+bby.^2);
vthper=sqrt(abs(pper));

pper2=(bbz.*pYY.*bbz-2*bby.*pYZ.*bbz);
pper2=pper2+(bby.*pZZ.*bby);
pper2=pper2./(bby.^2+bbz.^2);
vthper2=sqrt(abs(pper2));


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthpar,ay,'x/d_i','y/d_i',['\Pi_{||}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm1/' num2str(indexf,'%3.3i')])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper,ay,'x/d_i','y/d_i',['\Pi_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm2/' num2str(indexf,'%3.3i')])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper2,ay,'x/d_i','y/d_i',['\Pi_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm3/' num2str(indexf,'%3.3i')])
close all


indexf=indexf+1

close all
end

