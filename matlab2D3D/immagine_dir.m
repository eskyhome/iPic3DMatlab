function []=immagine(x,y,J1,name,lmt, Nsm)
 
J=smooth(J1,Nsm);
h=figure(1)
set(h,'Position',[167 451 976 351])
Ncut=max(Nsm*3,1)
imagesc(x,y,J(Ncut:end-Ncut,Ncut:end-Ncut)',lmt)
colorbar
set(gca,'fontsize',[14])
xlabel('x/d_i','fontsize',[14])
ylabel('y/d_i','fontsize',[14])
axis image
axis xy
%set(gca,'xdir','reverse','TickDir','out')
set(gca,'TickDir','out')
%print('-depsc','-r300',[name '.eps'])
%print('-dpng','-r300',[name '.png'])
saveas(gcf,[name '.fig'])
