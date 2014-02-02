aver=0;


indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_ion



ay=vecpot(xx,yy,bbx,bby);

ppar=(bbx.*pXX.*bbx+2*bbx.*pXY.*bby+2*bbx.*pXZ.*bbz);
ppar=ppar+(bby.*pYY.*bby+2*bby.*pYZ.*bbz);
ppar=ppar+(bbz.*pZZ.*bbz);
ppar=ppar./bbb.^2;
if(Ns>2)
vthpar=sqrt(abs(ppar./(rrho+rrhob).*qom(2)));
else
vthpar=sqrt(abs(ppar./rrho.*qom(2)));
end 

bmag2D=sqrt(bbx.^2+bby.^2);
pper=(bby.*pXX.*bby-2*bby.*pXY.*bbx);
pper=pper+(bbx.*pYY.*bbx);
pper=pper./bmag2D.^2;
if(Ns>2)
vthper=sqrt(abs(pper./(rrho+rrhob).*qom(2)));
else
vthper=sqrt(abs(pper./rrho.*qom(2)));
end 

perp2x=bbz.*bbx./(bbb.*bmag2D);
perp2y=bbz.*bby./(bbb.*bmag2D);
perp2z=-bmag2D./bbb;
pperp2=perp2x.*perp2x.*pXX + perp2y.*perp2y.*pYY + perp2z.*perp2z.*pZZ + 2*perp2x.*perp2y.*pXY + 2*perp2x.*perp2z.*pXZ + 2*perp2y.*perp2z.*pYZ;
if(Ns>2)
vthper2=sqrt(abs(pper2./(rrho+rrhob).*qom(2)));
else
vthper2=sqrt(abs(pper2./rrho.*qom(2)));
end
vthperT=.5*(vthper+vthper2);
pperT=.5*(pper+pper2);

limits_ion

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthpar,ay,'x/d_i','y/d_i',['v_{th,||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper,ay,'x/d_i','y/d_i',['v_{thi,\perp 1}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper2,ay,'x/d_i','y/d_i',['v_{th,\perp 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthperT,ay,'x/d_i','y/d_i',['v_{th,\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm7/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm7/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthpar./vthperT,ay,'x/d_i','y/d_i',['v_{th,||}/v_{th,\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm8/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm8/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,ppar,ay,'x/d_i','y/d_i',['\Pi_{||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper,ay,'x/d_i','y/d_i',['\Pi_{\perp 1}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper2,ay,'x/d_i','y/d_i',['\Pi_{\perp 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm6/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pperT,ay,'x/d_i','y/d_i',['\Pi_{\perp,avg}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm9/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm9/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper./pper2,ay,'x/d_i','y/d_i',['\Pi_{\perp,1}/\Pi_{\perp,2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm10/pperopper' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm10/pperopper' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,ppar./pperT,ay,'x/d_i','y/d_i',['\Pi_{||}/\Pi_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm10/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm10/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,ay,'x/d_i','y/d_i',['\Pi_{||}-\Pi_{\perp}-B^2/4\pi(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
contour(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,[-Bx0^2/8/pi*.005 -Bx0^2/8/pi*.005],'m','LineWidth',2)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm11/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm11/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpx,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
contour(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,[-Bx0^2/8/pi*.005 -Bx0^2/8/pi*.005],'m','LineWidth',2)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm12/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm12/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpx,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm12/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm12/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpy,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm13/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm13/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpz,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm14/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm14/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpx,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm12/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm12/rp' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpy,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm13/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm13/rp' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpz,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm14/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm14/rp' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpx,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm12/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm12/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpy,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm13/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm13/smooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpz,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm14/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm14/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpx,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm12/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm12/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpy,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm13/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm13/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpz,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm14/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm14/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvx,ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_x/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm15/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm15/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvy,ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_y/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm16/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm16/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvz,ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_z/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm17/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm17/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvx,.5),ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_x/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm15/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm15/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvy,.5),ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_y/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm16/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm16/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvz,.5),ay,'x/d_i','y/d_i',['m_i(\nabla \cdot n v v)_z/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm17/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm17/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,(ppar-pperT)./((bbx.^2+bby.^2+bbz.^2)/4/pi),ay,'x/d_i','y/d_i',['(\Pi_{||}-\Pi_{\perp})/(B^2/4\pi)(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['iDfilm18/' num2str(indexf,'%8.8i')])
saveas(gcf,['iDfilm18/' num2str(indexf,'%8.8i') '.fig'])
close all


indexf=indexf+1

close all
end

