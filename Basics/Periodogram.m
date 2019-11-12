clear; clc;
close all;
Fs = 1024;       % 采样频率
N = Fs;
nfft  =  N;   % fft计算点数大于采样数据点时，补零，计算N点fft

% 产生含有噪声的序列
n = (0:N-1)/N;
Xn = cos(2*pi*100*n)+3*cos(2*pi*200*n)+2*randn(size(n));
figure(2);
subplot(2,1,1);
plot(Xn);
axis([0 1200 -10 10]);
title('Signal with Noise'); grid on

%%
% 周期图法
window = boxcar(length(Xn));  % 矩形窗

% [cpsd,f] = periodogram(Xn,window,nfft,Fs);  % 调用函数
% cpsd = cpsd.*Fs;  % 注意，periodogram计算功率谱密度，目标是求功率谱，所以要乘以Fs

% 按照定义复现
CXf = fft(Xn, length(Xn));  % 求窗内fft，此处窗就是本身长度
CXf = abs(CXf);  % 复数取模
cpsd = CXf.^2/length(Xn);  % 计算周期谱

subplot(2,1,2);
semilogy(cpsd);  % 10*log10(Pxx)为分贝大小，此处为分贝的1/10
axis([0 600 10^(-2) 10^(4)]);
title('Using Periodogram');grid on
