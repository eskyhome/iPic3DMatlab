function [ii]=plot_part(nome,x0,y0,u0,v0,w0,q0,xx,yy,bbx,bby,bbz,va, ...
    time,nx,ny,itp,imin,xzero,yzero)

    xmin=xzero-.1;
    xmax=xzero+.1;
    ymin=yzero-.1;
    ymax=yzero+.1;
    times=2;


while(times<6)
ii=x0>xmin &x0<xmax &y0<ymax &y0>ymin ;
totp=sum(ii) ;
if(totp>10) 
    
usub=u0(ii);
vsub=v0(ii);
wsub=w0(ii);
qsub=q0(ii);
xsub=x0(ii);
ysub=y0(ii);
bxp=griddata(xx,yy,bbx,xsub,ysub);
byp=griddata(xx,yy,bby,xsub,ysub);
bzp=griddata(xx,yy,bbz,xsub,ysub);
bbbp=sqrt(bxp.^2+byp.^2+bzp.^2);
upp=(usub.*bxp+vsub.*byp+wsub.*bzp)./(bbbp+1e-10);


h=figure(1)
    
set(h,'Position' , [5 5 560 420]);
%hist(wpsub/va,150)


[totnum,nbinu,xrange,urange]=spaziofasi(xsub',upp',qsub',0);

%[totnum,nbinu,xrange,urange]=spaziofasi(ysub',wsub',qsub',0);

surf(xrange',urange'/va,nbinu','edgecolor','none','facecolor','blue')
lighting phong
shading interp
camlight(0,90) % luce dall'alto
view(2) %visione dall'alto
axis tight
colorbar
ylabel('v_p/v_a','fontsize',[14])
xlabel('y/d_i','fontsize',[14])
print('-dpng','-r300',[nome 'B' num2str(itp) '.png'])
title(['\omega_{ci}t=' num2str(time(itp))  '# Counts=' num2str(totnum)],'fontsize',[14])
h=figure(2)
    
set(h,'Position' , [5 500 560 420]);


bar(urange/va,mean(nbinu))
xlabel('v_p/v_a','fontsize',[14])
ylabel('weighted counts','fontsize',[14])
  
title(['\omega_{ci}t=' num2str(time(itp))  '# Counts=' num2str(totnum)],'fontsize',[14])
    
print('-dpng','-r300',[nome 'C' num2str(itp) '.png'])

return

else
    
        disp('geen particles')
    xmin=xzero-.1*times;
    xmax=xzero+.1*times;
    ymin=yzero-.1*times;
    ymax=yzero+.1*times;
    times=times+1
plot([xmin xmax xmax xmin xmin],[ymin ymin ymax ymax ymin],'k','linewidth',[3])

end 

end
disp('geen partikel')
