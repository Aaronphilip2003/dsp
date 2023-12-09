clear; % clear Matlab Workspace
close all; % close all figures
clc; % clear Command Window
 
A1=5; % amplitude of sine wave
fsig1=1000; % frequency, Hz, of the sine wave
T1=1/fsig1; % period, sec, of the sine wave
FS=8000; % sampling frequency, Hz
N=16; % number of sampling points for the sine wave and number of DFT points
 
t=0:T1/100:T1; % time axis values
x=A1*sin(2*pi*fsig1*t); % sine wave (continuous time) values

subplot(3,1,1);
plot(t,x); % plot of sine wave (continuous time) vs time
xlabel('time ms');
ylabel('x(t)');
 
n=0:N-1; % sample numbers
xn=A1*sin(2*pi*fsig1/FS*n); % sine wave (discrete time) values 
subplot(3,1,2);
stem(n,xn); % stem plot of sine wave (discrete time) vs sample number
xlabel('sample n');
ylabel('x(n)');
 
XFT=fft(xn,N); % N point DFT of xn using FFT function
disp(XFT); % display DFT values
XFTmag=abs(XFT); % magnitudes of DFT values                
subplot(3,1,3);
stem(n,XFTmag); % stem plot of DFT values vs sample number
xlabel('discrete frequency k');
ylabel('XFTmag(k)');
