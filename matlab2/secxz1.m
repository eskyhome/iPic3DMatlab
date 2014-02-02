addpath 'matlab-parsek'


close all

global results_dir variable_list

if(1==1)
    clear all
    %results_dir='/home/gianni/cluster/storage/parsek/mms/results/';
    %results_dir='/home/gianni/cluster/storage/parsek/mms/prit/';
    %results_dir='/home/gianni/cluster/storage/parsek/selffeding/results/';
    %results_dir='/home/gianni/simulations/storage/parsek/selffeding/prit/';
    %results_dir='/home/gianni/simulations/storage/parsek/mms/results/';

    %results_dir='/home/gianni/franklin/results/';
    results_dir='/home/gianni/Documents/workspace/Parsek2D/results/';
    variable_list='E B rho J';

    parsek2D
end

wci=Bx0
L=1

[nx ny nt]=size(Bx);

it=nt

iy=2;

% for mms
%wci=.0195;

%for self-feeding
%wci=.069;

vthe=uth(2);
va=wci;

time=Bx_time*wci*Dt;
aver=0;

recon=[];

indexf=1

for it=1:round(nt/20):nt/2

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
rrhoi=squeeze(sum(rhos1(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=(jsx0.*bbx+jsy0.*bby+jsz0.*bbz)./(rrho.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);

[xx yy]=meshgrid(1:ny,1:nx);

ay=vecpot(xx,yy,bbx,bby);
xx=xx/ny*Lx;
yy=yy/nx*Ly;

h=figure(1);
set(h,'Position' , [5 5 560 420]);
coplot(xx,yy,jsz0,ay,'x/d_i','y/d_i',['J_{ze}(\omega_{ci}t=' num2str(time(it)) ')'])
F1(indexf)=getframe(gcf);

if(1==0)
h=figure(2)
set(h,'Position' , [5 550 560 420]);
coplot(xx,yy,rrhoi*4*pi,ay,'x/d_i','y/d_i',['\rho_{i}(\omega_{ci}t=' num2str(time(it)) ')'])
F2(indexf)=getframe(gcf);
end

indexf=indexf+1;

end


for it=1:nt/2
    
bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);

[xx yy]=meshgrid(1:ny,1:nx);

ay=vecpot(xx,yy,bbx,bby);
recon=[recon;max(ay(end/2,:))-min(ay(end/2,:))];

end

h=figure(100)
set(h,'Position' , [1125 5 560 420]);
plot(recon/va)
xlabel('\omega_{ci}t','fontsize',[14])
ylabel('\Delta \Psi/B_0d_i','fontsize',[14])

return

name='film_mms_back'
movie2avi(F1,[name num2str(1) '.avi'],'fps',[2],'quality',[100])
%!ffmpeg -i film_mms1.avi -sameq -r 24 film_mms1.mpg
%!ffplay film_mms1.mpg
movie2avi(F2,[name num2str(2) '.avi'],'fps',[2],'quality',[100])

!ffmpeg -i film_mms_back1.avi -sameq -r 24 film_mms_backe1.mpg
!ffmpeg -i film_mms_back2.avi -sameq -r 24 film_mms_backe2.mpg
