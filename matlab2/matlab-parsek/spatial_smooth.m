function [a]=spatial_smooth(b,w)
a=b;
for icic=1:3
a(2:end-1,2:end-1)=(1-w)*a(2:end-1,2:end-1)+w*(a(1:end-2,2:end-1)+a(2:end-1,1:end-2)+a(3:end,2:end-1)+a(2:end-1,3:end))/4;
end
end
