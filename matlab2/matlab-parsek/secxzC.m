
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


ppar=(bbx.*pXX.*bbx+2*bbx.*pXY.*bby+2*bbx.*pXZ.*bbz);
ppar=ppar+(bby.*pYY.*bby+2*bby.*pYZ.*bbz);
ppar=ppar+(bbz.*pZZ.*bbz);
ppar=ppar./bbb.^2;
%vthlocal=sqrt(vthe^2.*(pXX+pYY+pZZ)/3);
vthlocal=sqrt(vthe^2.*abs(ppar));

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,epar,upar./vthlocal,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'],'k',-1,1,1)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm1/' num2str(indexf,'%8.8i') '.fig'])

close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,upar./vthlocal,epar,'x/d_i','y/d_i',['U_{e||}/v_{eLoc||}(\omega_{ci}t=' num2str(time(it)) ')'],'g',-1,1,1)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,epar,upar./vthlocal,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'],'k',1,-1,1)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,upar./vthlocal,epar,'x/d_i','y/d_i',['U_{e||}/v_{eLoc||}(\omega_{ci}t=' num2str(time(it)) ')'],'g',1,-1,1)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,-(rrho+rrhob)*4*pi,epar,'x/d_i','y/d_i',['\rho{e}(\omega_{ci}t=' num2str(time(it)) ')'],'w',-1,1,0)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot2(xx,yy,-(rrho+rrhob)*4*pi,epar,'x/d_i','y/d_i',['\rho{e}(\omega_{ci}t=' num2str(time(it)) ')'],'w',1,-1,0)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Cfilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['Cfilm6/' num2str(indexf,'%8.8i') '.fig'])
close all

indexf=indexf+1

close all
end
