addpath '/u/gianni/matlab/parsek/matlab-parsek'


close all

global results_dir variable_list

vai=1;

if(vai)
    %clear all
    %results_dir='/data/leuven/300/vsc30007/mms256/';
    %results_dir='/data/n/u0052182/mms1836v2/';
    %results_dir='/l/users/u0052182/mms/';
    %results_dir='/l/users/u0052182/Guide1836/results12/';
    %results_dir='/l/users/u0052182/results2/';
    %results_dir='/nobackup/gianni/mms256/';
    variable_list='E B rho J';

    parsek2D
end

wci=Bx0
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

vthe=uth(2);
va=wci;

time=double(Bx_time)*wci*Dt;
aver=0;

recon=[];
tslice=[];

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

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=((jsx0+jsxb).*bbx+(jsy0+jsyb).*bby+(jsz0+jszb).*bbz)./((rrho+rrhob).*bbb);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

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
print('-dpng',['film1/' num2str(indexf,'%3.3i')])

disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,(rrho+rrhob)*4*pi,ay,'x/d_i','y/d_i',['\rho_{e}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film2/' num2str(indexf,'%3.3i')])


disp('f3')
h=figure(3);
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/va,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,jsz0./rrho,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%F3(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film3/' num2str(indexf,'%3.3i')])

disp('f4')
h=figure(4);
set(h,'Position' , [565 550 560 420]);
coplot(xx,yy,epar,ay,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'])
%F4(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film4/' num2str(indexf,'%3.3i')])

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
print('-dpng',['film5/' num2str(indexf,'%3.3i')])

disp('f6')
h=figure(6);
set(h,'Position' , [1125 550 560 420]);
%coplot(xx,yy,(jsx0+jsxb)./(rrho+rrhob)/va,ay,'x/d_i','y/d_i',['V_{ex}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
coplot(xx,yy,strf,ay,'x/d_i','y/d_i',['\Psi(\omega_{ci}t=' num2str(time(it)) ')'])
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film6/' num2str(indexf,'%3.3i')])

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
