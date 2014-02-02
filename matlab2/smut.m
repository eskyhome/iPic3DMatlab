load kw
a=abs(Y(1:5,1:300)); 
s = [1 1 1 1 1 1 1];   
figure(1)
imagesc(0.5:5,-(f(1:302)*.009),log(conv2(a,s)'))
k=1:5;
w=1:10:300;
