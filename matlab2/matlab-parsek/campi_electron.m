
[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;dx=Lx/nx;
yy=yy/nx*Ly;dy=Ly/ny;

  
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

if(Ns>2) 
jsxb=squeeze(sum(Jxs2(1:end,1:end,it-aver:it),3))/(aver+1);
jsyb=squeeze(sum(Jys2(1:end,1:end,it-aver:it),3))/(aver+1);
jszb=squeeze(sum(Jzs2(1:end,1:end,it-aver:it),3))/(aver+1);
rrhob=squeeze(sum(rhos2(1:end,1:end,it-aver:it),3))/(aver+1);
else
jsxb=0*jsx0;
jsyb=0*jsy0;
jszb=0*jsz0;
rrhob=0*rrho;
end 


EdotJ=eex.*(jsx0+jsxb)+eey.*(jsy0+jsyb)+eez.*(jsz0+jszb);

bbb=sqrt(bbx.^2+bby.^2+bbz.^2);
jpar=((jsx0+jsxb).*bbx+(jsy0+jsyb).*bby+(jsz0+jszb).*bbz)./(bbb);
upar=jpar./(rrho+rrhob);
uparb=(jsxb.*bbx+jsyb.*bby+jszb.*bbz)./(rrhob.*bbb);
epar=(eex.*bbx+eey.*bby+eez.*bbz)./(bbb);
eparx=epar.*bbx./bbb;
epary=epar.*bby./bbb;
eparz=epar.*bbz./bbb;
[cepary,ceparx]=gradient(eparz,dx,dy);
cepary=-cepary;
[ceparz, cav]=curl(xx,yy,eparx,epary);
bccepx=(bby.*ceparz-bbz.*cepary)./(bbb).^3;
bccepy=(bbz.*ceparx-bbx.*ceparz)./(bbb).^3;
bccepz=(bbx.*cepary-bby.*ceparx)./(bbb).^3;

eperpx=eex-epar.*bbx./bbb;
eperpy=eey-epar.*bby./bbb;
eperpz=eez-epar.*bbz./bbb;
eperp=sqrt(eperpx.^2+eperpy.^2+eperpz.^2);
bmag2D=sqrt(bbx.^2+bby.^2);
eperp1=(bby.*eex-bbx.*eey)./bmag2D;
jperp1=(bby.*(jsx0+jsxb)-bbx.*(jsy0+jsyb))./bmag2D;
perp2x=bbz.*bbx./(bbb.*bmag2D);
perp2y=bbz.*bby./(bbb.*bmag2D);
perp2z=-bmag2D./bbb;
eperp2=perp2x.*eex+perp2y.*eey+perp2z.*eez;
jperp2=perp2x.*(jsx0+jsxb)+perp2y.*(jsy0+jsyb)+perp2z.*(jsz0+jszb);
EdotJpar=jpar.*epar;
EdotJperp1=jperp1.*eperp1;
EdotJperp2=jperp2.*eperp2;

uperpx=(jsx0+jsxb)./(rrho+rrhob)-upar.*bbx./bbb;
uperpy=(jsy0+jsyb)./(rrho+rrhob)-upar.*bby./bbb;
uperpz=(jsz0+jszb)./(rrho+rrhob)-upar.*bbz./bbb;
uperp=sqrt(uperpx.^2+uperpy.^2+uperpz.^2);

pXX=squeeze(sum(pxx(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
pXY=squeeze(sum(pxy(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
pXZ=squeeze(sum(pxz(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
pYY=squeeze(sum(pyy(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
pYZ=squeeze(sum(pyz(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
pZZ=squeeze(sum(pzz(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;

rpXX=squeeze(sum(pxx0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXY=squeeze(sum(pxy0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXZ=squeeze(sum(pxz0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYY=squeeze(sum(pyy0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYZ=squeeze(sum(pyz0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpZZ=squeeze(sum(pzz0(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
if(Ns>2)
rpXX=rpXX+squeeze(sum(pxx2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXY=rpXY+squeeze(sum(pxy2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXZ=rpXZ+squeeze(sum(pxz2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYY=rpYY+squeeze(sum(pyy2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYZ=rpYZ+squeeze(sum(pyz2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpZZ=rpZZ+squeeze(sum(pzz2(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
end
ohmx=eex+uperpy.*bbz-uperpz.*bby;
ohmy=eey-uperpx.*bbz+uperpz.*bbx;
ohmz=eez+uperpx.*bby-uperpy.*bbx;

divpx=divergence(xx,yy,pXX,pXY)./(rrho+rrhob);
divpy=divergence(xx,yy,pXY,pYY)./(rrho+rrhob);
divpz=divergence(xx,yy,pXZ,pYZ)./(rrho+rrhob);
divrpx=divergence(xx,yy,rpXX./qom(1),rpXY./qom(1))./(rrho+rrhob);
divrpy=divergence(xx,yy,rpXY./qom(1),rpYY./qom(1))./(rrho+rrhob);
divrpz=divergence(xx,yy,rpXZ./qom(1),rpYZ./qom(1))./(rrho+rrhob);

if(Ns>2)
vdelvx=divergence(xx,yy,(jsx0+jsxb).*(jsx0+jsxb)./(rrho+rrhob),(jsx0+jsxb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(1);
vdelvy=divergence(xx,yy,(jsx0+jsxb).*(jsy0+jsyb)./(rrho+rrhob),(jsy0+jsyb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(1);
vdelvz=divergence(xx,yy,(jsx0+jsxb).*(jsz0+jszb)./(rrho+rrhob),(jsz0+jszb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(1);
else
vdelvx=divergence(xx,yy,jsx0.*jsx0./rrho,jsx0.*jsy0./rrho)./rrho./qom(1);
vdelvy=divergence(xx,yy,jsx0.*jsy0./rrho,jsy0.*jsy0./rrho)./rrho./qom(1);
vdelvz=divergence(xx,yy,jsx0.*jsz0./rrho,jsz0.*jsy0./rrho)./rrho./qom(1);
end

[gx,gy]=gradient((jsx0+jsxb)./(rrho+rrhob),dx,dy);
%vdelvx=gx.*(jsx0+jsxb)./(rrho+rrhob)+gy.*(jsy0+jsyb)./(rrho+rrhob)
hsXX=pXX.*gx+pXY.*gy;
hsXY=pXY.*gx+pYY.*gy;
hsXZ=pXZ.*gx+pYZ.*gy;
[gx,gy]=gradient((jsy0+jsyb)./(rrho+rrhob),dx,dy);
%vdelvy=gx.*(jsx0+jsxb)./(rrho+rrhob)+gy.*(jsy0+jsyb)./(rrho+rrhob)
hsYY=pXY.*gx+pYY.*gy;
hsYZ=pXZ.*gx+pYZ.*gy;
[gx,gy]=gradient((jsz0+jszb)./(rrho+rrhob),dx,dy);
%vdelvz=gx.*(jsx0+jsxb)./(rrho+rrhob)+gy.*(jsy0+jsyb)./(rrho+rrhob)
hsZZ=pXZ.*gx+pYZ.*gy;
