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
% Welch����Bartlett���������������������
% һ��ѡ���ʵ��Ĵ�����w(n)����������ͼ����ǰֱ�Ӽӽ�ȥ������ʲô���Ĵ���������ʹ�׹��ƷǸ�
% �����ڷֶ�ʱ����ʹ����֮�����ص���������ʹ�����С

range = 'onesided';  % ���߹�����
index = round(nfft/2-1);

window_length = 20480;
noverlap = window_length*0.4;  % �����ص�
window1 = boxcar(window_length);  % ���δ�
[Pxx1,f] = pwelch(Xn,window1,noverlap,nfft,Fs,range);
window2 = hamming(window_length);  % ������
[Pxx2,f] = pwelch(Xn,window2,noverlap,nfft,Fs,range);
window3 = blackman(window_length);  % blackman��
[Pxx3,f] = pwelch(Xn,window3,noverlap,nfft,Fs,range);

subplot(2,1,2)
semilogy(Pxx1(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Boxcar');grid on

figure(2)
subplot(2,1,1)
semilogy(Pxx2(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Hamming');grid on

subplot(2,1,2)
semilogy(Pxx3(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(-5) 10^(7)]);
title('Welch-Blackman');grid on
