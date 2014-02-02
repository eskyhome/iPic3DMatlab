addpath 'matlab-parsek'


close all

global results_dir variable_list

vai=1;

if(vai)
    clear all
    results_dir='/data/n/u0052182/mms512/';
    %results_dir='/l/users/u0052182/mod14/';
    %results_dir='/l/users/u0052182/results2/';
    variable_list='E B rho J';

    parsek2D
end

wci=Bx0;
L=1;

[nx ny nt]=size(Bx);

it=nt

iy=2;

vthe=uth(2);
va=wci;

time=double(Bx_time)*wci*Dt;
aver=0;

recon=[];

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
rrho=squeeze(sum(rhos0(1:end,1:end,it-aver:it),3))/(aver+1);
rrhob=squeeze(sum(rhos2(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=(jsx0.*bbx+jsy0.*bby+jsz0.*bbz)./(rrho.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

[xx yy]=meshgrid(1:ny,1:nx);

ay=vecpot(xx,yy,bbx,bby);
xx=xx/ny*Lx;
yy=yy/nx*Ly;


disp('f2')
h=figure(2);
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,rrhob*4*pi,ay,'x/d_i','y/d_i',['\rho_{eb}(\omega_{ci}t=' num2str(time(it)) ')'])
%coplot(xx,yy,bbb,ay,'x/d_i','y/d_i',['N_e(\omega_{ci}t=' num2str(time(it)) ')'])
%F2(indexf)=getframe(gcf);
set(gcf, 'Renderer', 'zbuffer');
print('-dpng',['film2back/' num2str(indexf,'%3.3i')])

indexf=indexf+1

recon=[recon;max(ay(end/2,:))-min(ay(end/2,:))];

end

h=figure(100);
set(h,'Position' , [1125 5 560 420]);
plot(recon/va)
xlabel('\omega_{ci}t','fontsize',[14])
ylabel('\Delta \Psi/B_0d_i','fontsize',[14])
print('-dpng','film2back/recon')
%pause(.1)

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
