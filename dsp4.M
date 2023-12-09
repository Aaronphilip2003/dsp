clear;
close all;
clc;

%read audio file

[x,Fs]= audioread('flute.wav');
%[x,Fs] = audioread('machali.wav');
disp(['Sampling frequency "Fs" is ', num2str(Fs),' Hz ']);

%Enter the LPF specifications fp,ApdB,fs,AsdB.
%'fp' is normalized passband frequency w.r.t Nyquist Frequency Fs/2
%i.e fs= fsHz/(Fs/2) where fsHz is stopband frequency in Hz
%'AsdB' is stopband deviation ind dB

lpspec= input('Enter LPF specification [fp,ApdB,fs,AsdB] : ');
fp=lpspec(1);
ApdB=lpspec(2);
fs=lpspec(3);
AsdB=lpspec(4);
fc=(fp+fs)/2;% 'fc' is taken at the middle of the transition band
wc=2*pi*fc;%'wc' is the normalized cutoff radian frequency
ftran=(fs-fp); % 'ftran' is the normalized transition frequency
                % w.r.t Nyquist frequency Fs/2
disp(['Normalized transition frequency "ftran" is ', num2str(ftran)]);
Ndis=1024; %number of display points

% Convert 'ftran' w.r.t Fs/2 to a new value Fs
ftran=ftran/2;

%Select the required window function (rectangular,hanning, hamming,
%blackman) and generate filter impulse response
if(ApdB >= 0.7416) &&(AsdB<=21)
    sel=1;% rectangular window
    N=ceil(0.9/ftran);
    if rem(N,2) ==0
        N=N+1; % N must be an odd integer
    end
    disp(['Rectangular window of length N = ', num2str(N),' is chosen']);
    b=fir1(N-1,fc,'low',rectwin(N)); %FIR LPF coefficients (z domain)
    freqz(b,1,Ndis); %display frequency response of filter

elseif (ApdB >= 0.0546) &&(AsdB<=44)
    sel=2;% Hanning window
    N=ceil(3.1/ftran);
    if rem(N,2) ==0
        N=N+1; % N must be an odd integer
    end
    disp(['Hanning window of length N = ', num2str(N),' is chosen']);
    b=fir1(N-1,fc,'low',hann(N)); %FIR LPF coefficients (z domain)
    freqz(b,1,Ndis); %display frequency response of filter

elseif (ApdB >= 0.0194) &&(AsdB<=53)
    sel=3;% Hamming window
    N=ceil(3.3/ftran);
    if rem(N,2) ==0
        N=N+1; % N must be an odd integer
    end
    disp(['Hamming window of length N = ', num2str(N),' is chosen']);
    b=fir1(N-1,fc,'low',hamming(N)); %FIR LPF coefficients (z domain)
    freqz(b,1,Ndis); %display frequency response of filter

elseif (ApdB >= 0.0017) &&(AsdB<=74)
    sel=4;% blackman window
    N=ceil(5.5/ftran);
    if rem(N,2) ==0
        N=N+1; % N must be an odd integer
    end
    disp(['Blackman window of length N = ', num2str(N),' is chosen']);
    b=fir1(N-1,fc,'low',blackman(N)); %FIR LPF coefficients (z domain)
    freqz(b,1,Ndis); %display frequency response of filter
else
    error('error. Invalid filter specifications. ');
end
% Extract and filter the audio file using the FIR LPF
x=x(:,1); %select first column of 'x' and save it as 'x'
xlen= length(x); % obtain length of 'x'
disp(['Length of audio signal is ', num2str(xlen)]); % display value of 'xlen'
t=(0:length(x)-1); % time axis values for entire signal 'x'
%display value of 'timeduration'
timeduration= xlen*1/Fs;
disp(['Time duration of audio signal is ', num2str(timeduration) ' sec']);
xlp=filter(b,1,x);

figure('Name','Original and filtered signals');%plot figure name
subplot(2,1,1);
plot(t,x);
title('Original Signal');
xlabel('sample n');
ylabel('Original signal "x"');
ys=ylim;

subplot(2,1,2);
plot(t,xlp);
title('Lowpass Filtered Signal');
xlabel('sample n');
ylabel('Filtered signal "x"');
ylim(ys);
