function [totnum,nbinu,xrange,urange]=spaziofasi(xx,uu,qq,cyl)

ndiv=30;

xmin=min(xx(:))
xmax=max(xx(:))
umin=min(uu(:))
umax=max(uu(:))
% umin=-.4/4;
% umax=.4/4;
dx=(-xmin+xmax)/ndiv;
du=(-umin+umax)/ndiv;
xrange=xmin:dx:xmax;
urange=umin:du:umax;
[nbinx,binx]=histc(xx,xrange);
ibin=max(size(nbinx));
nbinu=[];
totnum=0;
for i=1:ibin
    utmp=uu(binx==i);
    qtmp=qq(binx==i);
    [nbin,bin]=histc(utmp,urange);
    totnum=totnum+sum(nbin);
    nbib=nbin*0;
    for j=1:ibin;nbin(j)=sum(abs(qtmp(bin==j)));end
    nbinu=[nbinu;nbin.*(xrange(i)+dx/2).^cyl];
end

