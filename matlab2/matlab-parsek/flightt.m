dnx=1;
dny=1;
for i=1:5
for j=1:3
tmp=squeeze(By(round(nx/2)+(j-2)*dnx,round(ny/2)+i*dny,:)/Bx0);
nt=max(size(tmp));
flights(i,j,flight_counter+1:nt+flight_counter)=squeeze(tmp/Bx0);
end
end

flight_counter=nt+flight_counter;


indexf=1;
