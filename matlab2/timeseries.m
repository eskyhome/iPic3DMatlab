dnx=nx/8;
dny=ny/8;
for i=1:1
for j=1:1
figure(1)
plot(time,squeeze(By(nx/2+j*dnx,ny/2+i*dny,:)/Bx0))
xlabel('\omega_{ci}t')
ylabel('B_{vert}')
title([num2str(xx(nx/2+j*dnx,ny/2+i*dny)),[num2str(yy(nx/2+j*dnx,ny/2+i*dny))])
end
end
print -dpng time1.png
