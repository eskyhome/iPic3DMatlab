
aver=0;

recon=[];
tslice=[];

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_electron

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);
strf=vecpot(xx,yy,(jsxb+jsx0)./(rrhob+rrho),(jsy0+jsyb)./(rrhob+rrho));

disp('f1')
h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz0+jszb,ay,'x/d_i','y/d_i',['J_{ze}(\omega_{ci}t=' num2str(time(it)) ')'])
%F1(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film1/' num2str(indexf,'%8.8i')])
saveas(gcf,['film1/' num2str(indexf,'%8.8i') '.fig'])

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,(rrho+rrhob)*4*pi,ay,'x/d_i','y/d_i',['\rho_{e}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film2/' num2str(indexf,'%8.8i')])
saveas(gcf,['film2/' num2str(indexf,'%8.8i') '.fig'])

disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/vthe,ay,'x/d_i','y/d_i',['U_{e||}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,jsz0./rrho,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%F3(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film3/' num2str(indexf,'%8.8i')])
saveas(gcf,['film3/' num2str(indexf,'%8.8i') '.fig'])

disp('f4')
h=figure(4);
set(h,'Position' , [565 550 560 420]);
coplot(xx,yy,epar,ay,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'])
%F4(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film4/' num2str(indexf,'%8.8i')])
saveas(gcf,['film4/' num2str(indexf,'%8.8i') '.fig'])
% h=figure(4);
% set(h,'Position' , [565 550 560 420]);
% coplot(xx,yy,jsx0./rrho,ay,'x/d_i','y/d_i',['V_{ex}(\omega_{ci}t=' num2str(time(it)) ')'])
% F4(indexf)=getframe(gcf);

disp('f5')
h=figure(5);
set(h,'Position' , [1125 550 560 420]);
%coplot(xx,yy,eez,ay,'x/d_i','y/d_i',['E_z(\omega_{ci}t=' num2str(time(it)) ')'])
coplot(xx,yy,rrhob,ay,'x/d_i','y/d_i',['\rho_b(\omega_{ci}t=' num2str(time(it)) ')'])
%F5(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film5/' num2str(indexf,'%8.8i')])
saveas(gcf,['film5/' num2str(indexf,'%8.8i') '.fig'])

disp('f6')
h=figure(6);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,(jsx0+jsxb)./(rrho+rrhob)/vthe,ay,'x/d_i','y/d_i',['V_{ex}/v_{the0}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film6/' num2str(indexf,'%8.8i')])
saveas(gcf,['film6/' num2str(indexf,'%8.8i') '.fig'])

resolution=Dx./c.*sqrt(4*pi*qom(1)*(rrhob+rrho));
resolution_lde=Dx./vthe.*sqrt(4*pi*qom(1)*(rrhob+rrho));
disp('f7')
h=figure(7);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,resolution,ay,'x/d_i','y/d_i',['\Delta_x/d_e(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film7/' num2str(indexf,'%8.8i')])
saveas(gcf,['film7/' num2str(indexf,'%8.8i') '.fig'])
close all

disp('f8')
h=figure(8);
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,(jsx0+jsxb)*4*pi,ay,'x/d_i','y/d_i',['J_{ex}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
%set(gcf,'fontsize',18)
print('-dpng',['film8/' num2str(indexf,'%8.8i')])
saveas(gcf,['film8/' num2str(indexf,'%8.8i') '.fig'])

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
%set(gcf,'fontsize',18)
%pause(.1)
fid = fopen('recon.txt','a');
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
