clear; clc;
close all;
Fs = 1024;       % ����Ƶ��
N = Fs;
nfft  =  N;   % fft����������ڲ������ݵ�ʱ�����㣬����N��fft

% ������������������
n = (0:N-1)/N;
Xn = cos(2*pi*100*n)+3*cos(2*pi*200*n)+2*randn(size(n));
figure(3);
subplot(2,1,1);
plot(Xn);
axis([0 1200 -10 10]);
title('Signal with Noise'); grid on

%%
% AR��
cpsd = pyulear(Xn, Fs, nfft); 
cpsd = abs(cpsd);
index=round(nfft/2-1);
subplot(2,1,2);
semilogy(cpsd(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(-2) 10^(4)]);
title('Using AR');grid on;
