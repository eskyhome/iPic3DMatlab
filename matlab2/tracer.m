plotonly=1;
if(plotonly==1)

aver=0;

sband=0:299;nband=299;

xupper=[];
yupper=[];
z1upper=[];z2upper=[];z3upper=[];
xlower=[];
ylower=[];
z1lower=[];z2lower=[];z3lower=[];
indexf=1
%for it=1:round(nt/10):nt
for it=round(1:nt)
close all    
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
rrhoi=squeeze(sum(rhos1(1:end,1:end,it-aver:it),3))/(aver+1);
rrhobi=squeeze(sum(rhos3(1:end,1:end,it-aver:it),3))/(aver+1);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
upar=((jsx0+jsxb).*bbx+(jsy0+jsyb).*bby+(jsz0+jszb).*bbz)./((rrho+rrhob).*bbb);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);
eperp=(-eex.*bby+eey.*bbx)./sqrt(bbx.^2+bby.^2);

[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;
ay=vecpot(xx,yy,bbx,bby);

aycut=ay(end/2,:);
ayxpoint=min(aycut)
c=contourc(xx(1,:),yy(:,1),ay,[ayxpoint ayxpoint]);

%figure(1)
%contour(xx(1,:),yy(:,1),ay,[ayxpoint ayxpoint],'k','linewidth',[3]);
%hold on
%contour(xx,yy,ay,20)  
indexf=indexf+1

[n1 n2]=size(c);
nsep=0;
pos=1;
while (pos<n2)
    %disp(['branch number=',num2str(nsep+1)]);
    xline=c(1,pos+1:pos+c(2,pos));
    xline=interp1(0:max(size(xline))-1,xline,sband/nband*max(size(xline)-1));
    yline=c(2,pos+1:pos+c(2,pos));
    yline=interp1(0:max(size(yline))-1,yline,sband/nband*max(size(yline)-1));
    z1line=griddata(xx,yy,upar,xline,yline);
    z2line=griddata(xx,yy,epar,xline,yline);
    z3line=griddata(xx,yy,eperp,xline,yline);
    nsep=nsep+1;
    pos=pos+c(2,pos)+1;
%figure
%plot(xline,yline)
%xlim([0 20])
%ylim([0 10]) 
%pause
    if(nsep==1)
	xupper=[xupper;xline];
	yupper=[yupper;yline];
	z1upper=[z1upper;z1line];
	z2upper=[z2upper;z2line];
	z3upper=[z3upper;z3line];
    end
    if(nsep==2)
	xlower=[xlower;xline];
	ylower=[ylower;yline];
	z1lower=[z1lower;z1line];
	z2lower=[z2lower;z2line];
	z3lower=[z3lower;z3line];
    end
end
disp(['number branches = ',num2str(nsep)])
end

end

close all
load cm_new

ttime=time(1:nt)
[ntime dummy]=size(ttime)
ssep=[zeros(ntime,1) cumsum(sqrt(diff(xupper,1,2).^2+diff(yupper,1,2).^2),2)];
[r c]=size(ssep);
for ir=1:r
ssep(ir,:)=ssep(ir,:)-max(ssep(ir,:))/2;
end

figure(1)
pcolor(ssep,ttime,z1upper)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z1upper(:))) max(abs(z1upper(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('V_{e||}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept1.eps
print -r300 -dpng xsept1.png

figure(2)
pcolor(ssep,ttime,z2upper)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z2upper(:))) max(abs(z2upper(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('E_{||}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept2.eps
print -r300 -dpng xsept2.png

figure(3)
pcolor(ssep,time,z3upper)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z3upper(:))) max(abs(z3upper(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('E_{\perp}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept3.eps
print -r300 -dpng xsept3.png

ssep=[zeros(ntime,1) cumsum(sqrt(diff(xlower,1,2).^2+diff(ylower,1,2).^2),2)];
[r c]=size(ssep);
for ir=1:r
ssep(ir,:)=ssep(ir,:)-max(ssep(ir,:))/2;
end

figure(4)
pcolor(ssep,ttime,z1lower)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z1lower(:))) max(abs(z1lower(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('V_{e||}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept4.eps
print -r300 -dpng xsept4.png

figure(5)
pcolor(ssep,ttime,z2lower)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z2lower(:))) max(abs(z2lower(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('E_{||}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept5.eps
print -r300 -dpng xsept5.png

figure(6)
pcolor(ssep,ttime,z3lower)
shading interp    
hold on
plot(zeros(size(ttime)),ttime,'k')
colorbar
colormap(cm_kbwrk)
caxis([-max(abs(z3lower(:))) max(abs(z3lower(:)))])
xlabel('distance from x-point (d_i)','fontsize',[12])
ylabel('\omega_{ci} t','fontsize',[12])
title('E_{\perp}','fontsize',[12])
set(gcf, 'Renderer', 'zbuffer');
%print -r300 -depsc xsept6.eps
print -r300 -dpng xsept6.png

