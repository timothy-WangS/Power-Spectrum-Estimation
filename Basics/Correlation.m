clear; clc;
close all;
Fs = 1024;       % 采样频率
N = Fs;
nfft  =  N;   % fft计算点数大于采样数据点时，补零，计算N点fft

% 产生含有噪声的序列
n = (0:N-1)/N;
Xn = cos(2*pi*10*n)+3*cos(2*pi*20*n)+2*randn(size(n));
figure(1);
subplot(2,1,1);
plot(Xn); 
axis([0 1200 -10 10]);
title('Signal with Noise'); grid on

%%
% 自相关法
% 根据维纳-辛钦定理，先求自相关函数，求其傅氏变换得功率谱
CXn = xcorr(Xn, 'unbiased');  % 计算自相关函数
CXk = fft(CXn,nfft);  % 傅氏变换
cpsd = abs(CXk);  % 取复数的模
index = round(nfft/2-1);  % 因为是对称的，只取前半段
subplot(2,1,2);
semilogy(cpsd(1:index));  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-2) 10^(4)]);
title('Using Correlation');grid on
