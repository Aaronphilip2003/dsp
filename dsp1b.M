clear ;
close all;
clc;

[x,fs]= audioread('machali.wav');
disp(['fs = ',num2str(fs)]);
x=x(:,1);
xlen= length(x);
disp(['xlen = ',num2str(xlen)]);
t=0:(length(x)-1);
timeduration= xlen* (1/fs);

u=16;
disp(['u = ',num2str(u)]);
xlen1=ceil((xlen/u));
disp(['xlen1 = ',num2str(xlen1)]);

v=7;
disp(['v = ',num2str(v)]);
for (r=1:xlen1)
    p1(r)=x((v-1)*xlen1+r);
end
figure('Name','FFT Analysis 1B');
subplot(4,1,1);
plot(t,x);
xlabel('n');
ylabel('x(n)');

XFFT=abs(fft(x,xlen));
n=0:xlen-1;
subplot(4,1,2);
stem(n,XFFT);
xlabel('Discrete Frequency (k)');
ylabel('XFFT(k)');

t1=(0:length(p1)-1);
subplot(4,1,3);
plot(t1,p1);
xlabel('n');
ylabel('p1(n)');


P1FFT= abs(fft(p1,xlen1));
n=0:xlen1-1;
subplot(4,1,4);
stem(n,P1FFT);
xlabel('Discrete Frequency (k)');
ylabel('P1FFT(k)');
