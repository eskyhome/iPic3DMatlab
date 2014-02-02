aver=0;


indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron


ay=vecpot(xx,yy,bbx,bby);

ppar=(bbx.*pXX.*bbx+2*bbx.*pXY.*bby+2*bbx.*pXZ.*bbz);
ppar=ppar+(bby.*pYY.*bby+2*bby.*pYZ.*bbz);
ppar=ppar+(bbz.*pZZ.*bbz);
ppar=ppar./bbb.^2;
if(Ns>2)
vthpar=sqrt(abs(ppar./(rrho+rrhob).*qom(1)));
else
vthpar=sqrt(abs(ppar./rrho.*qom(1)));
end 

bmag2D=sqrt(bbx.^2+bby.^2);
pper=(bby.*pXX.*bby-2*bby.*pXY.*bbx);
pper=pper+(bbx.*pYY.*bbx);
pper=pper./bmag2D.^2;
if(Ns>2)
vthper=sqrt(abs(pper./(rrho+rrhob).*qom(1)));
else
vthper=sqrt(abs(pper./rrho.*qom(1)));
end 

perp2x=bbz.*bbx./(bbb.*bmag2D);
perp2y=bbz.*bby./(bbb.*bmag2D);
perp2z=-bmag2D./bbb;
pper2=perp2x.*perp2x.*pXX + perp2y.*perp2y.*pYY + perp2z.*perp2z.*pZZ + 2*perp2x.*perp2y.*pXY + 2*perp2x.*perp2z.*pXZ + 2*perp2y.*perp2z.*pYZ;
if(Ns>2)
vthper2=sqrt(abs(pper2./(rrho+rrhob).*qom(1)));
else
vthper2=sqrt(abs(pper2./rrho.*qom(1)));
end

vthperT=.5*(vthper+vthper2);
pperT=.5*(pper+pper2);

limits

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthpar,ay,'x/d_i','y/d_i',['v_{th,||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm1/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper,ay,'x/d_i','y/d_i',['v_{thi,\perp 1}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm2/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm2/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthper2,ay,'x/d_i','y/d_i',['v_{th,\perp 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm3/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthperT,ay,'x/d_i','y/d_i',['v_{th,\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm7/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm7/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vthpar./vthperT,ay,'x/d_i','y/d_i',['v_{th,||}/v_{th,\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm8/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm8/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,ppar,ay,'x/d_i','y/d_i',['\Pi_{||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm4/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper,ay,'x/d_i','y/d_i',['\Pi_{\perp 1}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm5/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm5/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper2,ay,'x/d_i','y/d_i',['\Pi_{\perp 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm6/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm6/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pperT,ay,'x/d_i','y/d_i',['\Pi_{\perp,avg}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm9/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm9/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,pper./pper2,ay,'x/d_i','y/d_i',['\Pi_{\perp, 1}/\Pi_{\perp, 2}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm10/pperopper' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm10/pperopper' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,ppar./pperT,ay,'x/d_i','y/d_i',['\Pi_{||}/\Pi_{\perp}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm10/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm10/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,ay,'x/d_i','y/d_i',['\Pi_{||}-\Pi_{\perp}-B^2/4\pi(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
contour(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,[-Bx0^2/8/pi*.01 -Bx0^2/8/pi*.01],'m','LineWidth',2)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm11/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm11/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,1-(ppar-pperT)*4*pi./(bbx.^2+bby.^2+bbz.^2),ay,'x/d_i','y/d_i',['1-$\pi(\Pi_{||}-\Pi_{\perp})/B^2(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm11/firehose' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm11/forehose' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpx,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
contour(xx,yy,(ppar-pperT)-(bbx.^2+bby.^2+bbz.^2)/4/pi,[-Bx0^2/8/pi*.01 -Bx0^2/8/pi*.01],'m','LineWidth',2)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm12/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm12/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpx,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm12/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm12/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpy,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm13/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm13/' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divpz,ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm14/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm14/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpx,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm12/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm12/rp' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpy,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm13/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm13/rp' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,divrpz,ay,'x/d_i','y/d_i',['(\nabla \cdot P)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm14/rp' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm14/rp' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpx,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm12/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm12/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpy,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm13/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm13/smooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divpz,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot \Pi)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm14/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm14/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpx,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_x (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm12/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm12/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpy,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_y (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm13/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm13/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(divrpz,.5),ay,'x/d_i','y/d_i',['(\nabla \cdot P)_z (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm14/rpsmooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm14/rpsmooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvx,ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_x/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm15/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm15/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvy,ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_y/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm16/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm16/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,vdelvz,ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_z/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm17/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm17/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvx,.5),ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_x/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm15/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm15/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvy,.5),ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_y/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm16/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm16/smooth' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,spatial_smooth(vdelvz,.5),ay,'x/d_i','y/d_i',['m_e(\nabla \cdot n v v)_z/ne (\omega_{ci}t=' num2str(time(it)) ')'],lmt)
hold on 
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm17/smooth' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm17/smooth' num2str(indexf,'%8.8i') '.fig'])
close all


disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,(ppar-pperT)./((bbx.^2+bby.^2+bbz.^2)/4/pi),ay,'x/d_i','y/d_i',['(\Pi_{||}-\Pi_{\perp})/(B^2/4\pi)(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm18/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm18/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
resolution_lde_par=Dx./vthpar.*sqrt(4*pi*qom(1)*(rrhob+rrho));
coplot(xx,yy,resolution_lde_par,ay,'x/d_i','y/d_i',['D_x/\lambda({De,par})(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm19/PAR' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm19/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [565 5 560 420]);
resolution_lde_perp=Dx./vthperT.*sqrt(4*pi*qom(1)*(rrhob+rrho));
coplot(xx,yy,resolution_lde_perp,ay,'x/d_i','y/d_i',['D_x/\lambda({De,perp})(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['Dfilm20/' num2str(indexf,'%8.8i')])
saveas(gcf,['Dfilm20/' num2str(indexf,'%8.8i') '.fig'])
close all



indexf=indexf+1

close all
end

