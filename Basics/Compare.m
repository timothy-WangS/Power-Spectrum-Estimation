clear; clc;
close all;
Fs = 1024;
N = Fs;
nfft  =  N;

n = (0:N-1)/N;
Xn = cos(2*pi*100*n)+3*cos(2*pi*200*n)+2*randn(size(n));
figure(1);
plot(Xn);
axis([0 1200 -10 10]);
title('Signal with Noise'); grid on

%%
% 自相关法
CXn = xcorr(Xn, 'unbiased');
CXk = fft(CXn,nfft);
cpsd = abs(CXk);
index = round(nfft/2-1);
figure(2);
subplot(3,1,1);
semilogy(cpsd(1:index));
axis([0 600 10^(-2) 10^(4)]);
title('Using Correlation');grid on

% 周期图法
window = boxcar(length(Xn));
[cpsd,f] = periodogram(Xn,window,nfft,Fs);
subplot(3,1,2);
cpsd = cpsd.*Fs;
semilogy(cpsd);
axis([0 600 10^(-2) 10^(4)]);
title('Using Periodogram');grid on

% AR谱
cpsd = pyulear(Xn, Fs, nfft); 
cpsd = abs(cpsd);
index=round(nfft/2-1);
subplot(3,1,3);
semilogy(cpsd(1:index));
axis([0 600 10^(-2) 10^(4)]);
title('Using AR');grid on;
