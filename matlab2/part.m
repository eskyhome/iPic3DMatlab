addpath 'matlab-parsek'


close all

global results_dir variable_list

if(0==1)
    clear all
    results_dir='/home/gianni/cluster/storage/parsek/mms/prit/';
    %results_dir='/home/gianni/franklin/results/';
    %results_dir='/Users/gianni/Documents/runni/parsek/results/';
    %results_dir='/Users/gianni/Documents/runni/parsek/prit/';
%results_dir='/home/gianni/cluster/storage/parsek/selffeding/results/';

    variable_list='x v q  B J rho';

    parsek2D
end


[np ntp] = size(x0);
[nx ny nt]=size(Bx);

wci=.0195;dt=.25;
vthe=.045
va=.0195
time=x_time*wci*dt;
aver=0;

for itp=ntp/2+2:ntp/2+2
    
it=1+(itp-1)*nt/ntp

    
bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);

jsxs=squeeze(sum(Jxs2(1:end,1:end,it-aver:it),3))/(aver+1);
jsys=squeeze(sum(Jys2(1:end,1:end,it-aver:it),3))/(aver+1);
jszs=squeeze(sum(Jzs2(1:end,1:end,it-aver:it),3))/(aver+1);
rrho=squeeze(sum(rhos2(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=(jsxs.*bbx+jsys.*bby+jszs.*bbz)./(rrho.*bbb);

[xx yy]=meshgrid(1:ny,1:nx);

ay=vecpot(xx,yy,bbx,bby);
[aymin,imin]=min(ay(nx/2,:))
xx=xx/ny*20;
yy=yy/nx*10;


%
% Selection box
%

% caso=0;
% if(caso==1)
% xzero=.5*(xx(nx/2,imin)+xx(nx/2,imin+1))
% yzero=5;
% else
%     xzero=13.25+1;
%     yzero=5-1.4+.5;
% end
%     xmin=xzero-.03;
%     xmax=xzero+.03;
%     ymin=yzero-.03;
%     ymax=yzero+.03;
    
 
    
h=figure(3)
set(h,'Position' , [565 5 560 420]);
coplot(xx,yy,upar/va,ay,'x/d_i','z/d_i',['U_{s||}/v_a(\omega_{ci}t=' num2str(time(itp)) ')'])

[xzero,yzero] = ginput(1)
    xmin=xzero-.1;
    xmax=xzero+.1;
    ymin=yzero-.1;
    ymax=yzero+.1;
    
    hold on
    
plot([xmin xmax xmax xmin xmin],[ymin ymin ymax ymax ymin],'k','linewidth',[3])

print('-dpng','-r300',['fgA' num2str(itp) '.png'])

%extract particles within box   

 
plot_part('ion-bulk',[x0(:,itp);x2(:,itp)],[y0(:,itp);y2(:,itp)],[u0(:,itp);u2(:,itp)],...
    [v0(:,itp);v2(:,itp)],[w0(:,itp);w2(:,itp)],[q0(:,itp);q2(:,itp)],xx,yy,bbx,bby,bbz,va,time,nx,ny,itp,imin,xzero,yzero);

pause(.1)
end    
