aver=0;


indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron
[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);


limits

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,epar,ay,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,eperpx,ay,'x/d_i','y/d_i',['E_{\perp,x}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm2/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,eperpy,ay,'x/d_i','y/d_i',['E_{\perp,y}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,eperpz,ay,'x/d_i','y/d_i',['E_{\perp,z}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,eperp,ay,'x/d_i','y/d_i',['E_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm5/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,eperp,ay,'x/d_i','y/d_i',['E_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm5/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,bccepx,ay,'x/d_i','y/d_i',['(B x \nabla x E_{||})_x(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm6/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,bccepy,ay,'x/d_i','y/d_i',['(B x \nabla x E_{||})_y(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm7/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm7/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,bccepz,ay,'x/d_i','y/d_i',['(B x \nabla x E_{||})_z(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm8/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm8/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,sqrt(bccepx.^2+bccepy.^2+bccepz.^2),ay,'x/d_i','y/d_i',['|B x \nabla x E_{||}|(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Efilm9/' num2str(indexf,'%8.8i')])
saveas(gcf,['Efilm9/' num2str(indexf,'%8.8i') '.fig'])
close all


indexf=indexf+1

close all
end

