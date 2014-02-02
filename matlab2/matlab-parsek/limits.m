if(blowup) 
jmin=round(ny/2-ny/6);
jmax=round(ny/2+ny/6);
imin=round(nx/2-nx/6);
imax=round(nx/2+nx/6);

%jmin=round(ny/2-ny/8);
%jmax=round(ny/2+ny/8);
%imin=round(nx/2-nx/8);
%imax=round(nx/2+nx/8);

lmt=[imin,imax,jmin,jmax];
else
lmt=[1,nx,1,ny]
end
