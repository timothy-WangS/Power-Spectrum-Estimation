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
% Bartlett平均周期图的方法是将N点的有限长序列x(n)分段求周期图再平均。
window_length = 10240;
window = boxcar(window_length);  % 矩形窗
noverlap = 0;  % 分段数据是否重叠,该值要求小于窗大小
[Pxx,Pxxc] = psd(Xn,nfft,Fs,window,noverlap);  % psd函数现已被pwelch取代
index = round(nfft/2-1);
figure(1)
subplot(2,1,2)
semilogy(Pxx(1:index));  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-2) 10^(8)]);  % 只显示0-600个点，实际点数很多
title('Barlett');grid on
