plotonly=1;
if(plotonly==1)

aver=0;

z1horiz=[];z2horiz=[];z3horiz=[];

z1vertic=[];z2vertic=[];z3vertic=[];
indexf=1
%for it=1:round(nt/10):nt
for it=round(nt/2:nt/2)
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

[aymin, jmin]=min(ay(end/2,:));
imin=nx/2;


    z1vertic=bbx(:,jmin);
    z2vertic=bby(:,jmin);
    z3vertic=bbz(:,jmin);

    z1horiz=bbx(imin,:);
    z2horiz=bby(imin,:);
    z3horiz=bbz(imin,:);

figure(1)
subplot(2,3,1)
plot(yy(:,jmin),z1vertic)

subplot(2,3,2)
plot(yy(:,jmin),z2vertic)

subplot(2,3,3)
plot(yy(:,jmin),z3vertic)

subplot(2,3,4)
plot(xx(imin,:),z1horiz)

subplot(2,3,5)
plot(xx(imin,:),z2horiz)

subplot(2,3,6)
plot(xx(imin,:),z3horiz)

indexf=indexf+1


for ialfa=1:5
alfa=ialfa*pi/2/6
%offset=xx(imin,jmin)/2/ialfa
offset=0;
%alfa=pi/4;
    xline=xx(imin,:);
    yline=yy(imin,jmin)+tan(alfa)*(xx(imin,:)-xx(imin,jmin)-offset);
    z2line=griddata(xx,yy,bby,xline,yline);
h=figure(2)
set(h,'Position' , [5 5 860 1420]);

subplot(6,1,1)
pcolor(xx,yy,bby)
axis equal
axis tight
ylim([0 max(yy(:))])
shading interp
hold on
plot(xline,yline,'w')
subplot(6,1,ialfa+1) 
   plot(xline,z2line)
pause(.1)
end

end
print -dpng cuts2

end
figure(3)
plot(time,squeeze(By(end/2,end*3/4,:)/Bx0))
xlabel('\omega_{ci}t')
ylabel('B_{vert}')

print -dpng cuts3
