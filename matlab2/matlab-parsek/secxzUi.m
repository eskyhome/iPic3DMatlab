
aver=0;

recon=[];
tslice=[];

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_ion

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);

limits_ion

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,upar,ay,'x/d_i','y/d_i',['u_{i||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,uperp,ay,'x/d_i','y/d_i',['u_{i\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,uperpx,ay,'x/d_i','y/d_i',['u_{i\perp,x}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,uperpy,ay,'x/d_i','y/d_i',['u_{i\perp,y}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,uperpz,ay,'x/d_i','y/d_i',['u_{i\perp,z}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,ohmz,ay,'x/d_i','y/d_i',['(E+u_{i}\times B)_z(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm6/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,ohmy,ay,'x/d_i','y/d_i',['(E+u_{i}\times B)_y(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm7/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm7/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,ohmx,ay,'x/d_i','y/d_i',['(E+u_{i}\times B)_x(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['iUfilm8/' num2str(indexf,'%8.8i')])
saveas(gcf,['iUfilm8/' num2str(indexf,'%8.8i') '.fig'])
close all

indexf=indexf+1


end

return
