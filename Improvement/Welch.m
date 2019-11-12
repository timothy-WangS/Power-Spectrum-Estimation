clear; clc;
close all;
Fs = 1024;       % 采样频率
N = Fs*100;
nfft  =  N;   % fft计算点数大于采样数据点时，补零，计算N点fft

% 产生含有噪声的序列
n = (0:N-1)/N;
Xn = cos(2*pi*100*n)+3*cos(2*pi*200*n)+2*randn(size(n));
figure(1);
subplot(2,1,1);
plot(Xn);
axis([0 length(Xn) -10 10]);
title('Signal with Noise'); grid on

%%
% Welch法对Bartlett法进行了两方面的修正，
% 一是选择适当的窗函数w(n)，并在周期图计算前直接加进去，无论什么样的窗函数均可使谱估计非负
% 二是在分段时，可使各段之间有重叠，这样会使方差减小

range = 'onesided';  % 单边功率谱
index = round(nfft/2-1);

window_length = 20480;
noverlap = window_length*0.4;  % 数据重叠
window1 = boxcar(window_length);  % 矩形窗
[Pxx1,f] = pwelch(Xn,window1,noverlap,nfft,Fs,range);
window2 = hamming(window_length);  % 海明窗
[Pxx2,f] = pwelch(Xn,window2,noverlap,nfft,Fs,range);
window3 = blackman(window_length);  % blackman窗
[Pxx3,f] = pwelch(Xn,window3,noverlap,nfft,Fs,range);

subplot(2,1,2)
semilogy(Pxx1(1:index));  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Boxcar');grid on

figure(2)
subplot(2,1,1)
semilogy(Pxx2(1:index));  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Hamming');grid on

subplot(2,1,2)
semilogy(Pxx3(1:index));  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Blackman');grid on
