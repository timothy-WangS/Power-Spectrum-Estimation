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
window_length = 102400;
window_num = length(Xn)/window_length;

%%
% ����ط�
% ����ά��-���ն�������������غ��������丵�ϱ任�ù�����
CXn = xcorr(Xn, 'unbiased');  % ��������غ���
CXk = fft(CXn,nfft);  % ���ϱ任
cpsd = abs(CXk);  % ȡ������ģ
index = round(nfft/2-1);  % ��Ϊ�ǶԳƵģ�ֻȡǰ���
figure(1);
subplot(2,1,2);
semilogy(cpsd(1:index));  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(1) 10^(7)]);
title('Using Correlation');grid on

%%
window1 = boxcar(window_length);  % ���δ�
Win1 = fft(window1);
CXn = xcorr(Xn, 'unbiased');
CXk = fft(CXn, length(CXn));
Xxn1 = conv(CXk, Win1);
cpsd = abs(Xxn1)/window_length;  % ȡ������ģ
xaxis = (0:length(cpsd)-1)/2;
figure(2);
subplot(3,1,1);
semilogy(xaxis, cpsd);  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(1) 10^(7)]);
title('Boxcar');grid on

%%
window2 = hamming(window_length);  % ������
Win2 = fft(window2);
CXn = xcorr(Xn, 'unbiased');
CXk = fft(CXn, length(CXn));
Xxn2 = conv(CXk, Win2);
cpsd = abs(Xxn2)/window_length;  % ȡ������ģ
xaxis = (0:length(cpsd)-1)/2;
figure(2);
subplot(3,1,2);
semilogy(xaxis, cpsd);  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(1) 10^(7)]);
title('Hamming');grid on

%%
window3 = blackman(window_length);  % blackman��
Win3 = fft(window3);
CXn = xcorr(Xn, 'unbiased');
CXk = fft(CXn, length(CXn));
Xxn3 = conv(CXk, Win3);
cpsd = abs(Xxn3)/window_length;  % ȡ������ģ
xaxis = (0:length(cpsd)-1)/2;
figure(2);
subplot(3,1,3);
semilogy(xaxis, cpsd);  % 10*log10(Pxx)Ϊ�ֱ���С���˴�Ϊ�ֱ���1/10
axis([0 600 10^(1) 10^(7)]);
title('Blackman');grid on
