clear;
close all;
clc;

fp= input('Enter the passband cutoff frequency "fp" in Hz : ');
fs= input('Enter the stopband cutoff frequency "fs" in Hz : ');
Fs= input('Enter the sampling frequency "Fs" in Hz : ');

% Obtain corresponding prewarped frequencies
wp=2*pi*fp;
ws= 2*pi*fs;
wpp= tan(wp/(2*Fs));% passband prewarped cutoff frequency
wps= tan(ws/(2*Fs)); % stopband prewarped cutoff frequency

ApdB= input('Enter passband attenuation "ApdB": ');
AsdB= input('Enter stopband attenuation "AsdB": ');

%Obtain order of butterworth filter
N= 1/2*(log10((10^(AsdB/10)-1)/(10^(ApdB/10)-1))/log10(wps/wpp));
N=ceil(N);
%Obtain the cutoff frequency of the butterworth filter
wc=1/2*(wpp/(10^(ApdB/10)-1)^(1/(2*N))+wps/(10^(AsdB/10)-1)^(1/(2*N)));

if N==1
    % Obtain the transfer function of digital butterworth filter
    % numerator polynomial of "hd(z)"
    hdb=[wc,wc];
    % denominator polynomial of "hd(z)"
    hda=[ (1+wc), -(1-wc)];

elseif N==2
    % Obtain the transfer function of digital butterworth filter
    % numerator polynomial of "hd(z)"
    hdb=[wc,2*wc,wc];
    % denominator polynomial of "hd(z)"
    hda=[(1+sqrt(2)*wc+wc^2),(2*wc^2-2),(1-sqrt(2)*wc+wc^2)];
end

fc= wc/(2*pi)*Fs;
f=0:fc/1000:Fs/2; % frequency range will be 0 to Fs/2 in steps of fc/1000
hd = freqz(hdb,hda,f,Fs);% obtain frequency response of "hd(z)"
hdnorm=hd/hd(1);

figure(1);
%plot magnitude response of digital filter "hd(z)"
semilogx(f,20*log10(abs(hdnorm)),'r');
ylabel('|Hd(w| in dB --------->');
xlabel('frequency Hz ------------->');
legend('|Hd(w)|');
title('BLT IIR filter - limited frequency response(magnitude)');
grid on;

figure(2);
%plot phase response of digital filter "hd(z)"
semilogx(f,angle(hdnorm)*180/pi,'g');
ylabel('angle Hd(w) ------>');
xlabel('frequency Hz -------->');
legend('angle Hd(w)');
title('BLT IIR filter - limited frequency response(phase)');
grid on;

fe=0:fc/1000:3*Fs;% full frequency range of interest in Hz for "hd(z)"
hd = freqz(hdb,hda, fe,Fs); % Obtain frequency response of "hd(z)"
hdnorm=hd/hd(1);

figure(3);
%plot magnitude response of digital filter "hd(z)"
plot(fe,20*log10(abs(hdnorm)),'r');
ylabel('|Hd(w| in dB ------>');
xlabel('frequency Hz -------->');
legend('|Hd(w)|');
title('BLT IIR filter - limited frequency response(magnitude)');
grid on;

figure(4);
%plot phase response of digital filter "hd(z)"
plot(fe,angle(hdnorm)*180/pi,'g');
ylabel('angle Hd(w) ------>');
xlabel('frequency Hz -------->');
legend('angle Hd(w)');
title('BLT IIR filter - limited frequency response(phase)');
grid on;
