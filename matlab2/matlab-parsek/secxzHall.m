
aver=0;

recon=[];
tslice=[];

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron

ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

sx=(eey.*bbz-eez.*bby)/4/pi;
sy=(eez.*bbx-eex.*bbz)/4/pi;
sz=(eex.*bby-eey.*bbx)/4/pi;
divs=divergence(xx,yy,sx,sy);

spar=(sx.*bbx+sy.*bby+sz.*bbz)./bbb;
spar2D=(sx.*bbx+sy.*bby)./bmag2D;

limits

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,bbz,ay,'x/d_i','y/d_i',['B_z(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH1/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH1/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,eez,ay,'x/d_i','y/d_i',['E_z(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH2/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH2/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,bby,ay,'x/d_i','y/d_i',['B_y(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH3/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH3/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,eey,ay,'x/d_i','y/d_i',['E_y(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH4/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH4/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,bbx,ay,'x/d_i','y/d_i',['B_x(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH5/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH5/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,eex,ay,'x/d_i','y/d_i',['E_x(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH6/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH6/' num2str(indexf,'%8.8i') '.fig'])
close all

limits_ion
disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,sx,ay,'x/d_i','y/d_i',['S_x(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH7/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH7/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,sy,ay,'x/d_i','y/d_i',['S_y(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH8/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH8/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,sz,ay,'x/d_i','y/d_i',['S_z(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH9/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH9/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,divs,ay,'x/d_i','y/d_i',['\nabla \cdot S(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH10/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH10/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,sqrt(eex.^2+eey.^2+eez.^2),ay,'x/d_i','y/d_i',['E(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH11/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH11/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,sqrt(eex.^2+eey.^2+eez.^2),ay,'x/d_i','y/d_i',['E(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH12/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH12/' num2str(indexf,'%8.8i') '.fig'])
close all



disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,spar,ay,'x/d_i','y/d_i',['S_{||}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH12/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH12/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f1')
h=figure(1);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,spar2D,ay,'x/d_i','y/d_i',['S_{||xy}(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['filmH13/' num2str(indexf,'%8.8i')])
saveas(gcf,['filmH13/' num2str(indexf,'%8.8i') '.fig'])
close all


%disp('f3')
%h=figure(3);
%set(h,'Position' , [565 5 560 420]);
%coplot(xx,yy,(jsz0+jszb)*4*pi,ay,'x/d_i','y/d_i',['J_{ez}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['filmH3/' num2str(indexf,'%8.8i')])

%disp('f4')
%h=figure(4);
%set(h,'Position' , [565 550 560 420]);
%coplot(xx,yy,rrhob,ay,'x/d_i','y/d_i',['\rho_b(\omega_{ci}t=' num2str(time(it)) ')'])
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['filmH4/' num2str(indexf,'%8.8i')])

%resolution=Dx./c.*sqrt(4*pi*qom(1)*(rrhob+rrho));
%disp('f5')
%h=figure(5);
%set(h,'Position' , [565 5 560 420]);
%coplot(xx,yy,resolution,ay,'x/d_i','y/d_i',['\Delta_x/d_e(\omega_{ci}t=' num2str(time(it)) ')'])
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['filmH5/' num2str(indexf,'%8.8i')])
%close all

%disp('f6')
%h=figure(6);
%set(h,'Position' , [1125 550 560 420]);
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'],lmt)
%set(gcf, 'Renderer', 'zbuffer');
%print('-dpng',['filmH7/' num2str(indexf,'%8.8i')])
%saveas(gcf,['filmH7/' num2str(indexf,'%8.8i') '.fig'])
%close all
% surf(xx,yy-max(yy(:))/2,eez,'edgecolor','none','facecolor','blue')
% lighting phong
% shading interp
% camlight(0,90) % luce dall'alto
% view(2) %visione dall'alto
% axis tight

indexf=indexf+1

recon=[recon;max(ay(end/2,:))-min(ay(end/2,:))];
tslice=[tslice;time(it)];
close all
end

h=figure(100);
set(h,'Position' , [1125 5 560 420]);
plot(tslice,recon/va)
xlabel('\omega_{ci}t','fontsize',[14])
ylabel('\Delta \Psi/B_0d_i','fontsize',[14])
%pause(.1)
fid = fopen('recon.txt','wt');
fprintf(fid,'%12.8f  %12.8f\n',[double(tslice)';recon'/va]);
fclose(fid);

%secxz2r
return

name='film_mms_512_'
movie2avi(F1,[name num2str(1) '.avi'],'fps',[2],'quality',[100])
%!ffmpeg -i film_mms1.avi -sameq -r 24 film_mms1.mpg
%!ffplay film_mms1.mpg
movie2avi(F2,[name num2str(2) '.avi'],'fps',[2],'quality',[100])
movie2avi(F3,[name num2str(3) '.avi'],'fps',[2],'quality',[100])
movie2avi(F4,[name num2str(4) '.avi'],'fps',[2],'quality',[100])
movie2avi(F5,[name num2str(5) '.avi'],'fps',[2],'quality',[100])
!ffmpeg -i film_mms_256II_1.avi -sameq -r 24 film_mms_256II_1.mpg
!ffmpeg -i film_mms_256II_2.avi -sameq -r 24 film_mms_256II_2.mpg
!ffmpeg -i film_mms_256II_3.avi -sameq -r 24 film_mms_256II_3.mpg
!ffmpeg -i film_mms_256II_4.avi -sameq -r 24 film_mms_256II_4.mpg
!ffmpeg -i film_mms_256II_5.avi -sameq -r 24 film_mms_256II_5.mpg
