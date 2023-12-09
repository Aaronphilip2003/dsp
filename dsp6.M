close all;
clear;
clc;

[x,fs] = audioread('laughter.wav');
%[x,fs] = audioread('machali.wav');

disp(['fs = ',num2str(fs)]); % display value of 'fs'
x = x(:,1); % select first column of 'x' and save it as 'x'                        
xlen = length(x); % obtain length of 'x'
disp(['xlen = ',num2str(xlen)]); % display value of 'xlen'
n = (0:length(x)-1); % discrete time values 'n' for entire signal 'x'
timeduration=xlen*1/fs;

data = input('Enter "M", "N", "L" as [M, N, L]: ');
M = data(1);  % decimation factor (integer) "M"
N = data(2);  % order of FIR LPF (even integer) "N"
L = data(3);  % decimated output sequence length "L"

h = fir1(N,1/M); % FIR LPF with normalized cutoff frequency "1/M"
xlpf = filter(h,1,x); % Low pass filtering of "x" to obtain "xlpf"
xdec = downsample(xlpf,M); % Downsample "xlpf" to obtain decimated signal
                           % "xdec"

% Decimated sequence "xdec" sample indices: 0,1,2,...(L-2),(L-1)       DSP
% Decimated sequence "xdec" sample indices: 1,2,3,...(L-1),L           MAT 
% 
% Input/filtered sequence "x"/"xlpf" sample indices: 0,M,2M,...(L-1)M  DSP
% Input/filtered sequence "x"/"xlpf" sample indices: 
%                                              1,M+1,2M+1,...(L-1)M+1  MAT

% Plot complete input, filtered and decimated sequences
figure(1);
subplot(3,1,1);
stem(x);
title('Original signal complete');
ylabel('Original signal complete');
xlabel('samples n');

subplot(3,1,2);
stem(xlpf);
title('LP filtered signal complete');
ylabel('LP filtered signal complete');
xlabel('samples n');

subplot(3,1,3);
stem(xdec);
title('Decimated signal complete')
ylabel('Decimated signal complete');
xlabel('samples n');

% Plot selected portion of input, filtered and decimated sequences
figure(2);
subplot(3,1,1);
stem(x(1:((L - 1)*M + 1)));
title('Original signal selected');
ylabel('Original signal selected');
xlabel('samples n');
axis([1,((L - 1)*M + 1),-0.2,0.2]);

subplot(3,1,2);
stem(xlpf(1:((L - 1)*M + 1)));
title('LP filtered signal selected');
ylabel('LP filtered signal selected');
xlabel('samples n');
axis([1,((L - 1)*M + 1),-0.1,0.1]);

subplot(3,1,3);
stem(xdec(1:L));
title('Decimated signal selected')
ylabel('Decimated signal selected');
xlabel('samples n');
axis([1,L,-0.2,0.2]);

% Verify that "xdec" is correctly downsampled from "xlpf"

%  Enter any 4 decimated time sample indices for "xdec"
 time_samples = input('Enter decimated time sample indices as [TS1,TS2,TS3,TS4]: ');
 TS1 = time_samples(1);
 TS2 = time_samples(2);
 TS3 = time_samples(3);
TS4 = time_samples(3);

 % Compute corresponding time sample indices for "xlpf"
 CTS1 = M*(TS1 - 1) + 1;
 CTS2 = M*(TS2 - 1) + 1;
 CTS3 = M*(TS3 - 1) + 1;
 CTS4 = M*(TS4 - 1) + 1;
 
% Check that the corresponding values of "xdec" and "xlpf" are the same
z1 = xdec(TS1) - xlpf(CTS1);
 z2 = xdec(TS2) - xlpf(CTS2);
 z3 = xdec(TS3) - xlpf(CTS3);
z4 = xdec(TS4) - xlpf(CTS4);
 
% % % Display the corresponding values and differences
disp([xdec(TS1),xdec(TS2),xdec(TS3),xdec(TS4)]);
 
disp('Values of "xlpf" are : ');
 disp([xlpf(CTS1),xlpf(CTS2),xlpf(CTS3),xlpf(CTS4)]);
 disp('Differences are : ');
 disp([z1,z2,z3,z4])
