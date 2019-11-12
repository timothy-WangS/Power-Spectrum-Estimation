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
% ����ͼ��
CXf = fft(Xn, length(Xn));
CXf = abs(CXf);
cpsd = CXf.^2/length(Xn);
subplot(2,1,2);
semilogy(cpsd);
axis([0 600 10^(-2) 10^(5)]);
title('Using Periodogram');grid on

%%
% ƽ���Ľ�������ͼ��
window_num = 4;
window_length = length(Xn)/window_num;
cpsd_final = zeros(1, window_length);
for ind = 1:window_num
    if ind == 1
        Xxn = Xn(1:window_length);
    else
        Xxn = Xn(window_length*(ind-1)+1:window_length*ind);
    end
    CXf = fft(Xxn, window_length);
    CXf = abs(CXf);
    cpsd = CXf.^2/window_length;
    cpsd_final = cpsd_final + cpsd;
end

cpsd_final = cpsd_final./window_num;
figure(2);
subplot(2,1,1);
plot(Xn);
axis([0 length(Xn) -10 10]);
title('Signal with Noise'); grid on
subplot(2,1,2);
xaxis = (0:length(cpsd_final)-1)*window_num;
semilogy(xaxis, cpsd_final);
axis([0 600 10^(-2) 10^(5)]);
title('Using Periodogram');grid on
