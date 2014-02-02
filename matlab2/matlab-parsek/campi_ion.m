
[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;

   
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

if(Ns>2) 
jsxb=squeeze(sum(Jxs3(1:end,1:end,it-aver:it),3))/(aver+1);
jsyb=squeeze(sum(Jys3(1:end,1:end,it-aver:it),3))/(aver+1);
jszb=squeeze(sum(Jzs3(1:end,1:end,it-aver:it),3))/(aver+1);
rrhob=squeeze(sum(rhos3(1:end,1:end,it-aver:it),3))/(aver+1);
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


pXX=squeeze(sum(pxxi(1:end,1:end,it-aver:it),3))/(aver+1);
pXY=squeeze(sum(pxyi(1:end,1:end,it-aver:it),3))/(aver+1);
pXZ=squeeze(sum(pxzi(1:end,1:end,it-aver:it),3))/(aver+1);
pYY=squeeze(sum(pyyi(1:end,1:end,it-aver:it),3))/(aver+1);
pYZ=squeeze(sum(pyzi(1:end,1:end,it-aver:it),3))/(aver+1);
pZZ=squeeze(sum(pzzi(1:end,1:end,it-aver:it),3))/(aver+1);

rpXX=squeeze(sum(pxx1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXY=squeeze(sum(pxy1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXZ=squeeze(sum(pxz1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYY=squeeze(sum(pyy1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYZ=squeeze(sum(pyz1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpZZ=squeeze(sum(pzz1(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
if(Ns>2)
rpXX=rpXX+squeeze(sum(pxx3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXY=rpXY+squeeze(sum(pxy3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpXZ=rpXZ+squeeze(sum(pxz3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYY=rpYY+squeeze(sum(pyy3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpYZ=rpYZ+squeeze(sum(pyz3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
rpZZ=rpZZ+squeeze(sum(pzz3(1:end,1:end,it-aver:it),3))/(aver+1);%/vthe^2;
end 

ohmx=eex+uperpy.*bbz-uperpz.*bby;
ohmy=eey-uperpx.*bbz+uperpz.*bbx;
ohmz=eez+uperpx.*bby-uperpy.*bbx;

divpx=divergence(xx,yy,pXX,pXY)./(rrho+rrhob);
divpy=divergence(xx,yy,pXY,pYY)./(rrho+rrhob);
divpz=divergence(xx,yy,pXZ,pYZ)./(rrho+rrhob);
divrpx=divergence(xx,yy,rpXX./qom(2),rpXY./qom(2))./(rrho+rrhob);
divrpy=divergence(xx,yy,rpXY./qom(2),rpYY./qom(2))./(rrho+rrhob);
divrpz=divergence(xx,yy,rpXZ./qom(2),rpYZ./qom(2))./(rrho+rrhob);

if(Ns>2)
vdelvx=divergence(xx,yy,(jsx0+jsxb).*(jsx0+jsxb)./(rrho+rrhob),(jsx0+jsxb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(2);
vdelvy=divergence(xx,yy,(jsx0+jsxb).*(jsy0+jsyb)./(rrho+rrhob),(jsy0+jsyb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(2);
vdelvz=divergence(xx,yy,(jsx0+jsxb).*(jsz0+jszb)./(rrho+rrhob),(jsz0+jszb).*(jsy0+jsyb)./(rrho+rrhob))./(rrho+rrhob)./qom(2);
else
vdelvx=divergence(xx,yy,jsx0.*jsx0./rrho,jsx0.*jsy0./rrho)./rrho./qom(2);
vdelvy=divergence(xx,yy,jsx0.*jsy0./rrho,jsy0.*jsy0./rrho)./rrho./qom(2);
vdelvz=divergence(xx,yy,jsx0.*jsz0./rrho,jsz0.*jsy0./rrho)./rrho./qom(2);
end


