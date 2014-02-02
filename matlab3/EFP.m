load EnFluxPerp.mat;
xhist=-15-xhist/100*30;
hold off
n1=10
n2=50
n3=100
semilogy(xhist,histperp2(:,n1),'r')
hold on
semilogy(xhist,histperp2(:,n2),'b')
semilogy(xhist,histperp2(:,n3),'m')
binleg=round(bins/1e3);
legend(num2str(binleg(n1)),num2str(binleg(n2)),num2str(binleg(n3)),'Location','SouthEast')
set(gca,'xdir','reverse','TickDir','out')
xlabel('x/R_E','fontsize',[14])
set(gca,'fontsize',[14])
print -depsc -painters en_channels.eps

