load CHZ126HR2/data/SummaryQuantities.txt;

dt=.6;

cycle=SummaryQuantities(:,1)*dt;
Ke=SummaryQuantities(:,2);
Ki=SummaryQuantities(:,3);
Kh=SummaryQuantities(:,4);
Qe=SummaryQuantities(:,5);
Qi=SummaryQuantities(:,6);
Qh=SummaryQuantities(:,7);
Ne=SummaryQuantities(:,8);
Ni=SummaryQuantities(:,9);
Nh=SummaryQuantities(:,10);
Te=SummaryQuantities(:,11)*256;
Ti=SummaryQuantities(:,12);
Th=SummaryQuantities(:,13);

L_square=33;
Vol=4/3*pi*L_square^3;

subplot(2,2,1)
semilogy(cycle,Ke./Ki(1),'b',cycle,Ki./Ki(1),'r',cycle,Kh./Kh(1),'k')
ylabel('Kinetic Energy (rel)')
xlabel('\omega_{pi}t')
subplot(2,2,2)
plot(cycle,-Qe./Qi(1),'b',cycle,Qi./Qi(1),'ro',cycle,Qh./Qh(1),'k')
ylabel('Charge (rel)')
xlabel('\omega_{pi}t')
subplot(2,2,3)
plot(cycle,Ne./Ni(1),'b',cycle,Ni./Ni(1),'ro',cycle,Nh./Nh(1),'k')
ylabel('Number of particles')
xlabel('\omega_{pi}t')
subplot(2,2,4)
plot(cycle,Te./Ti(1),'b',cycle,Ti./Ti(1),'r',cycle,Th./Th(1),'k')
ylabel('Temperature (rel)')
xlabel('\omega_{pi}t')


load CHZ126/data/SummaryQuantities.txt;

dt=.3;

cycle=SummaryQuantities(:,1)*dt;
Ke=SummaryQuantities(:,2);
Ki=SummaryQuantities(:,3);
Kh=SummaryQuantities(:,4);
Qe=SummaryQuantities(:,5);
Qi=SummaryQuantities(:,6);
Qh=SummaryQuantities(:,7);
Ne=SummaryQuantities(:,8);
Ni=SummaryQuantities(:,9);
Nh=SummaryQuantities(:,10);
Te=SummaryQuantities(:,11)*256;
Ti=SummaryQuantities(:,12);
Th=SummaryQuantities(:,13);

L_square=33;
Vol=4/3*pi*L_square^3;

subplot(2,2,1)
hold on
semilogy(cycle,Ke./Ki(1),'b',cycle,Ki./Ki(1),'r',cycle,Kh./Kh(1),'k')
ylabel('Kinetic Energy (rel)')
xlabel('\omega_{pi}t')
subplot(2,2,2)
hold on
plot(cycle,-Qe./Qi(1),'b',cycle,Qi./Qi(1),'ro',cycle,Qh./Qh(1),'k')
ylabel('Charge (rel)')
xlabel('\omega_{pi}t')
subplot(2,2,3)
hold on
plot(cycle,Ne./Ni(1),'b',cycle,Ni./Ni(1),'ro',cycle,Nh./Nh(1),'k')
ylabel('Number of particles')
xlabel('\omega_{pi}t')
subplot(2,2,4)
hold on
plot(cycle,Te./Ti(1),'b',cycle,Ti./Ti(1),'r',cycle,Th./Th(1),'k')
ylabel('Temperature (rel)')
xlabel('\omega_{pi}t')


print -dpng plotsummary
