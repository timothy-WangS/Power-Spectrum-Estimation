clear; clc;
close all;
Fs = 1024;       % ����Ƶ��
N = Fs*100;
nfft  =  N;   % fft����������ڲ������ݵ�ʱ�����㣬����N��fft

% ������������������
n = (0:N-1)/N;
Xn = cos(2*pi*100*n)+3*cos(2*pi*200*n)+2*randn(size(n));
figure(1);
subplot(2,1,1);
plot(Xn);
axis([0 length(Xn) -10 10]);
title('Signal with Noise'); grid on

%%
% Bartlettƽ������ͼ�ķ����ǽ�N������޳�����x(n)�ֶ�������ͼ��ƽ����
window_length = 10240;
window = boxcar(window_length);  % ���δ�
noverlap = 0;  % �ֶ������Ƿ��ص�,��ֵҪ��С�ڴ���С
[Pxx,Pxxc] = psd(Xn,nfft,Fs,window,noverlap);  % psd�������ѱ�pwelchȡ��
index = round(nfft/2-1);
figure(1)
subplot(2,1,2)
semilogy(Pxx(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(-2) 10^(8)]);  % ֻ��ʾ0-600���㣬ʵ�ʵ����ܶ�
title('Barlett');grid on
