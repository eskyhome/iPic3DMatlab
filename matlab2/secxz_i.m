addpath 'matlab-parsek'


close all

global results_dir variable_list

if(0==1)
    clear all
    %results_dir='/home/gianni/cluster/storage/parsek/mms/results/';
    results_dir='/home/gianni/cluster/storage/parsek/mms/prit/';
    %results_dir='/home/gianni/cluster/storage/parsek/selffeding/results/';
    %results_dir='/home/gianni/cluster/storage/parsek/selffeding/prit/';

    %results_dir='/home/gianni/franklin/results/';
    %results_dir='/Users/gianni/Documents/runni/parsek/results/';
    variable_list='E B rho J';

    parsek2D
end

wci=1
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

% for mms
wci=.0195;

%for self-feeding
wci=.069;

vthe=uth(2);
va=wci;

time=Bx_time*wci*Dt;
aver=0;

recon=[];

indexf=1
for it=1:nt
    
bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);
eex=squeeze(sum(Ex(1:end,1:end,it-aver:it),3))/(aver+1);
eey=squeeze(sum(Ey(1:end,1:end,it-aver:it),3))/(aver+1);
eez=squeeze(sum(Ez(1:end,1:end,it-aver:it),3))/(aver+1);
jsx0=squeeze(sum(Jxs1(1:end,1:end,it-aver:it),3))/(aver+1);
jsy0=squeeze(sum(Jys1(1:end,1:end,it-aver:it),3))/(aver+1);
jsz0=squeeze(sum(Jzs1(1:end,1:end,it-aver:it),3))/(aver+1);
rrho=squeeze(sum(rhos1(1:end,1:end,it-aver:it),3))/(aver+1);


bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=(jsx0.*bbx+jsy0.*bby+jsz0.*bbz)./(rrho.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

[xx yy]=meshgrid(1:ny,1:nx);

ay=vecpot(xx,yy,bbx,bby);
xx=xx/ny*Lx;
yy=yy/nx*Ly;

h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz0,ay,'x/d_i','y/d_i',['J_{zi}(\omega_{ci}t=' num2str(time(it)) ')'])
F1(indexf)=getframe(gcf);

h=figure(2)
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,rrho*4*pi,ay,'x/d_i','y/d_i',['\rho_{i}(\omega_{ci}t=' num2str(time(it)) ')'])
F2(indexf)=getframe(gcf);

h=figure(3)
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/va,ay,'x/d_i','y/d_i',['U_{i||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,jsz0./rrho,ay,'x/d_i','y/d_i',['U_{e||}/v_a(\omega_{ci}t=' num2str(time(it)) ')'])
F3(indexf)=getframe(gcf);

h=figure(4)
set(h,'Position' , [565 550 560 420]);
coplot(xx,yy,epar,ay,'x/d_i','y/d_i',['E_{||}(\omega_{ci}t=' num2str(time(it)) ')'])
F4(indexf)=getframe(gcf);

h=figure(5)
set(h,'Position' , [1125 550 560 420]);
coplot(xx,yy,eez,ay,'x/d_i','y/d_i',['E_z(\omega_{ci}t=' num2str(time(it)) ')'])
F5(indexf)=getframe(gcf);

% surf(xx,yy-max(yy(:))/2,eez,'edgecolor','none','facecolor','blue')
% lighting phong
% shading interp
% camlight(0,90) % luce dall'alto
% view(2) %visione dall'alto
% axis tight

indexf=indexf+1;

recon=[recon;max(ay(end/2,:))-min(ay(end/2,:))];

h=figure(100)
set(h,'Position' , [1125 5 560 420]);
plot(recon/va)
xlabel('\omega_{ci}t','fontsize',[14])
ylabel('\Delta \Psi/B_0d_i','fontsize',[14])
pause(.1)
end

return

name='film_mms_back'
movie2avi(F1,[name num2str(1) '.avi'],'fps',[2],'quality',[100])
%!ffmpeg -i film_mms1.avi -sameq -r 24 film_mms1.mpg
%!ffplay film_mms1.mpg
movie2avi(F2,[name num2str(2) '.avi'],'fps',[2],'quality',[100])
movie2avi(F3,[name num2str(3) '.avi'],'fps',[2],'quality',[100])
movie2avi(F4,[name num2str(4) '.avi'],'fps',[2],'quality',[100])
movie2avi(F5,[name num2str(5) '.avi'],'fps',[2],'quality',[100])
!ffmpeg -i film_mms_back1.avi -sameq -r 24 film_mms_bulki1.mpg
!ffmpeg -i film_mms_back2.avi -sameq -r 24 film_mms_bulki2.mpg
!ffmpeg -i film_mms_back3.avi -sameq -r 24 film_mms_bulki3.mpg
!ffmpeg -i film_mms_back4.avi -sameq -r 24 film_mms_bulki4.mpg
!ffmpeg -i film_mms_back5.avi -sameq -r 24 film_mms_bulki5.mpg
