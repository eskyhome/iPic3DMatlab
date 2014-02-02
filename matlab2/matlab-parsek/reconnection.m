
aver=0;

recon=[];
tslice=[];

indexf=indexg
%for it=1:round(nt/10):nt
for it=1:nt
    
campi_recon

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);

indexf=indexf+1

recon=[recon;max(ay(end/2,:))-min(ay(end/2,:))];
tslice=[tslice;time(it)];
close all
end

%h=figure(100);
%set(h,'Position' , [1125 5 560 420]);
%plot(tslice,recon/va)
%xlabel('\omega_{ci}t','fontsize',[14])
%ylabel('\Delta \Psi/B_0d_i','fontsize',[14])
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
