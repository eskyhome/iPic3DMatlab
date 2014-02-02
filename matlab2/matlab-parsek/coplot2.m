function [ym] = coplot(x2,y2,f,ay,xlab,ylab,tit,color,ix,iy,ic)

x=x2-max(x2(:))/2;
y=y2-max(y2(:))/2;

%ym=max(y(:))/2;
close all
hold off
fmin1=min(f(:));
fmax1=max(f(:));
pcolor(x,y,f)
title(tit,'fontsize',[18])
shading interp
colorbar
hold on
aymin=min((ay(:)));
aymax=max((ay(:)));
fmax=max(fmax1,fmin1);
fmin=min(fmin1,fmax1);
ay2=((ay-aymin)/(aymax-aymin)*(fmax-fmin)+fmin);


contour(x,y,ay2,10,color)
%contour(x,y,ay2,levels,'w')
xlabel(xlab,'fontsize',[18])
ylabel(ylab,'fontsize',[18])

if(ix<0)
xlim([min(x(:)) 0])
%xlim([min(x(:))/2 0])
else
xlim([0 max(x(:))])
%xlim([0 max(x(:))/2])
end
if(iy<0)
ylim([min(y(:))*2/3 0])
else
ylim([0 max(y(:))*2/3])
end

if(ic)
load cm_new
colormap(cm_kbwrk)
caxis([-max(abs([fmin fmax])) max(abs([fmin fmax]))])
else
colormap(jet)
end

set(gca,'fontsize',[18])

end
