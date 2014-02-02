
[xx yy]=meshgrid(1:ny,1:nx);

xx=xx/ny*Lx;
yy=yy/nx*Ly;

bbx=squeeze(sum(Bx(1:end,1:end,it-aver:it),3))/(aver+1);
bby=squeeze(sum(By(1:end,1:end,it-aver:it),3))/(aver+1);
bbz=squeeze(sum(Bz(1:end,1:end,it-aver:it),3))/(aver+1);
eex=squeeze(sum(Ex(1:end,1:end,it-aver:it),3))/(aver+1);
eey=squeeze(sum(Ey(1:end,1:end,it-aver:it),3))/(aver+1);
eez=squeeze(sum(Ez(1:end,1:end,it-aver:it),3))/(aver+1);

% electrons
jsx0=squeeze(sum(Jxs0(1:end,1:end,it-aver:it),3))/(aver+1);
jsy0=squeeze(sum(Jys0(1:end,1:end,it-aver:it),3))/(aver+1);
jsz0=squeeze(sum(Jzs0(1:end,1:end,it-aver:it),3))/(aver+1);
rrho=squeeze(sum(rhos0(1:end,1:end,it-aver:it),3))/(aver+1);

if(Ns>2) 
jsxb=squeeze(sum(Jxs2(1:end,1:end,it-aver:it),3))/(aver+1);
jsyb=squeeze(sum(Jys2(1:end,1:end,it-aver:it),3))/(aver+1);
jszb=squeeze(sum(Jzs2(1:end,1:end,it-aver:it),3))/(aver+1);
rrhobe=squeeze(sum(rhos2(1:end,1:end,it-aver:it),3))/(aver+1);
else
jsxb=0*jsx0;
jsyb=0*jsy0;
jszb=0*jsz0;
rrhob=0*rrho;
end 


% ions
jsxi=squeeze(sum(Jxs1(1:end,1:end,it-aver:it),3))/(aver+1);
jsyi=squeeze(sum(Jys1(1:end,1:end,it-aver:it),3))/(aver+1);
jszi=squeeze(sum(Jzs1(1:end,1:end,it-aver:it),3))/(aver+1);
rrhoi=squeeze(sum(rhos1(1:end,1:end,it-aver:it),3))/(aver+1);

if(Ns>2) 
jsxbi=squeeze(sum(Jxs3(1:end,1:end,it-aver:it),3))/(aver+1);
jsybi=squeeze(sum(Jys3(1:end,1:end,it-aver:it),3))/(aver+1);
jszbi=squeeze(sum(Jzs3(1:end,1:end,it-aver:it),3))/(aver+1);
rrhobi=squeeze(sum(rhos3(1:end,1:end,it-aver:it),3))/(aver+1);
else
jsxbi=0*jsxi;
jsybi=0*jsyi;
jszbi=0*jszi;
rrhobi=0*rrhoi;
end 

EdotJtot=eex.*(jsx0+jsxb+jsxi+jsxbi)+eey.*(jsy0+jsyb+jsyi+jsybi)+eez.*(jsz0+jszb+jszi+jszbi);

eexp=eex+((jsy0+jsyb).*bbz-(jsz0+jszb).*bby)./(rrho+rrhob);
eeyp=eey+((jsz0+jszb).*bbx-(jsx0+jsxb).*bbz)./(rrho+rrhob);
eezp=eez+((jsx0+jsxb).*bby-(jsy0+jsyb).*bbx)./(rrho+rrhob);

EpdotJp=eexp.*(jsxi+jsxbi-(rrhoi+rrhobi)./(rrho+rrhob).*(jsx0+jsxb));
EpdotJp=EpdotJp+eeyp.*(jsyi+jsybi-(rrhoi+rrhobi)./(rrho+rrhob).*(jsy0+jsyb));
EpdotJp=EpdotJp+eezp.*(jszi+jszbi-(rrhoi+rrhobi)./(rrho+rrhob).*(jsz0+jszb));

clearvars eexp eeyp eeyp 
