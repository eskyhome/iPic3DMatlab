function [ym] = cocoplot(x,y,f,ay,xlab,ylab,tit)

ym=max(y(:))/2;ym=0;

hold off
contour(x,y-ym,ay./min((ay(:))).*max(abs(f(:))),60,'r:')
xlabel(xlab,'fontsize',[18])
ylabel(ylab,'fontsize',[18])
title(tit,'fontsize',[18])
hold on
pmin=min(f(:));
pmax=max(f(:));
contour(x,y-ym,(f-pmin)./(pmax-pmin),30,'b')
set(gca,'fontsize',[18])
end
