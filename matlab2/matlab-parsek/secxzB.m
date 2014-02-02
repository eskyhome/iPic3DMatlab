aver=0;


indexf=indexg
for it=1:nt
    
campi_electron

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

%disp('f1')
%h=figure(1);
%set(h,'Position' , [565 5 560 420]);
%coplot(xx,yy,upar/vthe,ay,'x/d_i','y/d_i',['U_{e||}/v_e(\omega_{ci}t=' num2str(time(it)) ')'])
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['Bfilm1/' num2str(indexf,'%8.8i')])
%saveas(gcf,['Bfilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pXX,ay,'x/d_i','y/d_i',['\Pi_{xxe}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Bfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['Bfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pYY,ay,'x/d_i','y/d_i',['\Pi_{yye}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Bfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['Bfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

%disp('f1')
%h=figure(1);
%set(h,'Position' , [565 5 560 420]);
%coplot(xx,yy,pZZ,ay,'x/d_i','y/d_i',['\Pi_{zze}(\omega_{ci}t=' num2str(time(it)) ')'])
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['Bfilm4/' num2str(indexf,'%8.8i')])
%close all

vthlocal=sqrt(vthe^2*(pXX+pYY+pZZ)/3);

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar./vthlocal,ay,'x/d_i','y/d_i',['U_{e||}/v_{eLoc}(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Bfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['Bfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all

indexf=indexf+1

close all
end
