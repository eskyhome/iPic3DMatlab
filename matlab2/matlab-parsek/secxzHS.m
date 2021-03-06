aver=0;


indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron


ay=vecpot(xx,yy,bbx,bby);

hspar=(bbx.*hsXX.*bbx+2*bbx.*hsXY.*bby+2*bbx.*hsXZ.*bbz);
hspar=hspar+(bby.*hsYY.*bby+2*bby.*hsYZ.*bbz);
hspar=hspar+(bbz.*hsZZ.*bbz);
hspar=hspar./bbb.^2; 

bmag2D=sqrt(bbx.^2+bby.^2);
hsper=(bby.*hsXX.*bby-2*bby.*hsXY.*bbx);
hsper=hsper+(bbx.*hsYY.*bbx);
hsper=hsper./bmag2D.^2;

perp2x=bbz.*bbx./(bbb.*bmag2D);
perp2y=bbz.*bby./(bbb.*bmag2D);
perp2z=-bmag2D./bbb;
hsper2=perp2x.*perp2x.*hsXX + perp2y.*perp2y.*hsYY + perp2z.*perp2z.*hsZZ + 2*perp2x.*perp2y.*hsXY + 2*perp2x.*perp2z.*hsXZ + 2*perp2y.*perp2z.*hsYZ;

limits



disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hspar,ay,'x/d_i','y/d_i',['H_{||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hsper,ay,'x/d_i','y/d_i',['H_{\perp 1}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hsper2,ay,'x/d_i','y/d_i',['H_{\perp 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hspar./(rrho+rrhob)*qom(1),ay,'x/d_i','y/d_i',['H_{||}/\rho(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hsper./(rrho+rrhob)*qom(1),ay,'x/d_i','y/d_i',['H_{\perp 1}/\rho(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,hsper2./(rrho+rrhob)*qom(1),ay,'x/d_i','y/d_i',['H_{\perp 2}/\rho(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['HSfilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['HSfilm6/' num2str(indexf,'%8.8i') '.fig'])
close all


indexf=indexf+1

close all
end

