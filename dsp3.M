clc;
clear all;
close all;
%Display of CT sine wave
A = 5;
F = 1000;
T = 1/F;
t = 0:T/100:T;
y = A*sin(2*pi*F*t)
subplot(3,1,1);
plot(t,y);
title("Sin Wave in CT");
xlabel("Time Period");
ylabel("Amplitude");
%Display of DT sine signal
N = 8;
n = 0:N-1;
fs = 8000;
f = F/fs;
y1 = A*sin(2*pi*n*f)
subplot(3,1,2);
stem(n,y1);
title("Sin Wave in DT");
xlabel("Time Period");
ylabel("Amplitude");
%Find frequency components of sin wave using N point
DFT
y2 = fft(y1,N)
y2mag = abs(y2)
subplot(3,1,3);
stem(n,y2mag);
title("DFT");

%Frequency content of Audio Signal
clc;
clear all;
close all;
[y,Fs] = audioread('flute.wav');
disp(Fs);
L = length(y)
%Continuous Signal
t =0:L-1;
subplot(4,1,1);
plot(t,y);
title('Original File');
xlabel("Time Period");
ylabel("Amplitude");
%Frequency Response
n = 0:L-1;
y1 = fft(y,L)
y1mag = abs(y1)
subplot(4,1,2);
stem(n,y1mag);
title("DFT");
xlabel("Time Period");
ylabel("Amplitude");
%Display small segment of original signal
u=12
disp(['u=',num2str(u)]);
xlen1 = ceil((L)/u);
disp(['xlen1',num2str(xlen1)]);
v=1;
disp(['v=',num2str(v)]);
for r=1:xlen1
p1(r) = y((v-1)*xlen1+r);
end
t1 = (0:length(p1)-1);
subplot(4,1,3);

plot(t1,p1);
xlabel("Time Period");
ylabel('p1(n)');
%FFT
p1FFT = abs(fft(p1,xlen1));
n =0:xlen1-1;
subplot(4,1,4);
stem(n,p1FFT);
xlabel("Discrete Frequency k");
ylabel('p1FFT(k)');
