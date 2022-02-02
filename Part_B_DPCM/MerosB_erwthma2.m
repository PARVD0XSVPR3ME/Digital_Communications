clear
clc
load source.mat;
n=1:length(x);
[y11,~]=DPCM(x,4,1);
[y12,~]=DPCM(x,8,1);

[y21,~]=DPCM(x,4,2);
[y22,~]=DPCM(x,8,2);

[y31,~]=DPCM(x,4,3);
[y32,~]=DPCM(x,8,3);

figure
subplot(3,1,1)
    plot(n,x,'b',n,y11,'r',n,y12,'g');
    title('Prediction error for N = 1 and p=4,p=8');
    legend('x','y (p=4)','y (p=8)');
    xlabel('Discrete Time n');
    ylabel ('Signal Value');
    
subplot(3,1,2)
    plot(n,x,'b', n,y21,'r',n ,y22,'g');
    title('Prediction error for N = 2 and p=4,p=8');
    legend('x','y (p=4)','y (p=8)');
    xlabel('Discrete Time n');
    ylabel ('Signal Value');
    
subplot(3,1,3)
    plot(n,x,'b', n,y31,'r',n ,y32,'g');
    title('Prediction error for N = 3 and p=4,p=8');  
    legend('x','y (p=4)','y (p=8)');
    xlabel('Discrete Time n');
    ylabel ('Signal Value');
     