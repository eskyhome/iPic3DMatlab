function [exdet,exavg]=analisi_traces(ex,b,nome,Dt,Navg,wpi,wci0,wci,wlh,mratio,xp,yp,zp) 

[nsat n]=size(ex);

NFFT=n-Navg+1;
w=hamming(NFFT);
t=(0:NFFT-1)*Dt;
T=max(t);
Fs=2*pi/T;
%The FFT already has the 2pi, so f is really omega, the circular frequency
f = Fs*(0:NFFT/2);


exavg=ex;
for i=1:nsat
exavg(i,:)=tsmovavg(ex(i,:),'s',Navg);
end
exdet=ex(:,Navg:end)-exavg(:,Navg:end);
exavg=exavg(:,Navg:end);


figure
subplot(3,1,1)

plot(exavg(1,:))

title(['xsat=' num2str(xp(1)) ', ysat=',num2str(yp(1)) ', zsat=',num2str(zp(1)) ])
ylabel(nome)
xlabel('cycle')
xlim([0 NFFT])

subplot(3,1,2)
plot(t,exdet(1,:),'r')
ylabel([nome '(detrended)'])
xlabel('\omega_{pi0}t')
xlim([0 max(t)])

subplot(3,1,3)
%plot(t,exdet,'.','MarkerSize',[1])
%ylabel(nome)
%xlabel('\omega_{pi0}t')
spectrogram(exdet(1,:),128,120,512,1/Dt,'yaxis')
title(nome)
hold on
size(t)
size(b(1,Navg:end))
plot(t,b(1,Navg:end)*mratio/2/pi,'w','Linewidth',2)
plot(t,b(1,Navg:end)*mratio/2/pi/2,'w--','Linewidth',2)
set(gca,'yscale','log')
set(gca,'YTick',[.01 .1 1])

set(gcf,'Renderer','zbuffer')

file=['trace_' nome '.png'];
print('-dpng',file)
file=['trace_' nome '.eps'];
print('-depsc','-painters',file)

figure

y=zeros(size(exdet));

for i=1:nsat
y(i,:)=w'.*(exdet(i,:));
end
Y = fft2(y);
minval=min(2*abs(Y(1,1:NFFT/2+1)));
maxval=max(2*abs(Y(1,1:NFFT/2+1)));
loglog(f,2*abs(Y(1,1:NFFT/2+1)))
xlabel('\omega/ (\omega_{pi0})')
hold on
loglog([wpi wpi],[minval, maxval],'k')
loglog(sqrt(mratio)*[wpi wpi]/wpi,[minval, maxval],'k--')
loglog([wlh wlh],[minval, maxval],'r')
loglog([wci wci]*mratio,[minval, maxval],'m--')
loglog([wci wci],[minval, maxval],'m')

title(['[k:pla, m:cyc r:lhdi] xsat=' num2str(xp(1)) '  ysat=',num2str(yp(1)) ', zsat=',num2str(zp(1)) ])
ylabel(['FFT(' nome ')'])

set(gcf,'Renderer','zbuffer')

file=['fft_' nome '.png'];
print('-dpng',file)
file=['fft_' nome '.eps'];
print('-depsc','-painters',file)

figure

%spectrogram(exdet(1,:),128,120,128,1/Dt,'yaxis')
%title([nome '  [k:pla, m:cyc r:lhdi] xsat=' num2str(xp(1)) '  ysat=',num2str(yp(1)) ', zsat=',num2str(zp(1)) ])
%hold on
%size(t)
%size(b(1,Navg:end))
%plot(t,b(1,Navg:end)*mratio/2/pi,'w','Linewidth',2)
%set(gca,'yscale','log')
%file=['spec_' nome '.png'];
%print('-dpng',file)
