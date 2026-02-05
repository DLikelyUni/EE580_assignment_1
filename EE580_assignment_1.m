%Assignment 1 - sem 2
clear;
stunum_l=[2,0,2,1,1,2,9,8,5];
stunum_d=[2,0,2,1,2,9,6,6,3];
x1=stunum_l;
x2=stunum_d;

for i=1:99 %Generate signal with length N=900 samples
    x1=[x1,stunum_l];
    x2=[x2,stunum_d];
end
x1=x1-mean(x1);%zero mean signal
x2=x2-mean(x2);%zero mean signal

fs=round((2985+9663)/2);%Sampling frequency 6324Hz
clearvars stunum_l stunum_d i
%%            % Sampling frequency                    
X1=fft(x1,1024);%1024 point Fast Fourier transform of x1
X2=fft(x2,1024);%1024 point Fast Fourier transform of x2

load("Hd1.mat");
load("Hd2.mat");

Hd1=single(Hd1.Numerator);
Hd2=single(Hd2.Numerator);

y1=filter(Hd1,1,x1);
Y1=fft(y1,1024);%1024 point Fast Fourier transform of y1

y2=filter(Hd2,1,x2);
Y2=fft(y2,1024);%1024 point Fast Fourier transform of y2
      
L = 1024;             % Length of signal
t = ((0:L-1)*(1/fs));
t900 = ((0:900-1)*(1/fs));

%% Time series of original signals            % Sampling period 
figure(1)
tiledlayout(2,1)
nexttile
plot(t(1:27)*1000,x1(1:27));
title('x1: Lewis')
xlabel('t(ms)')
ylabel('amplitude')
nexttile
plot(t(1:27)*1000,x2(1:27));
title('x2: Duncan')
xlabel('t(ms)')
ylabel('amplitude')

%% fft of original signals
% figure(2)
% tiledlayout(2,1)
% nexttile
% plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)));
% % xlim([0 30]);
% title('|fft X1|')
% xlabel('f (Hz)')
% ylabel('amplitude')
% nexttile
% plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)));
% % xlim([0 30]);
% title('|fft X2|')
% xlabel('f(Hz)')
% ylabel('amplitude')

%% Bandstop filtered signal x1[n]

figure('Name','x1 vs y1')
tiledlayout(2,1)
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)));
% ylim([0 1600]);
title('|fft X1|')
xlabel('f (Hz)')
ylabel('amplitude')
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y1)));
% ylim([0 1600]);
title('band stop')
xlabel('f(Hz)')
ylabel('amplitude')

%overlay x1 vs bandstop
figure('Name','x1 vs y1:overlay')
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)),'b');
hold on;
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y1)),'--r');
xlabel('f(Hz)')
ylabel('amplitude')
legend('|fft X1|','|fft bandstop X1|')
title('X1, Bandstop, fd=705Hz')

%% Bandstop filtered signal x1[n]
figure('Name','x2 vs y2')
tiledlayout(2,1)
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)));
% ylim([0 1600]);
title('|fft X2|')
xlabel('f (Hz)')
ylabel('dB')
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y2)));
% ylim([0 1600]);
title('band stop')
xlabel('f(Hz)')
ylabel('dB')

%overlay x2 vs bandstop
figure('Name','x2 vs y2:overlay')
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)),'b');
hold on;
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y2)),'--r');
xlabel('f(Hz)')
ylabel('amplitude')
legend('|fft X2|','|fft bandstop X2|')
title('X2, Bandstop, fd=2810Hz')

%% time series plots of bandpassed signals
figure('Name','time series y1, y2')
tiledlayout(2,2)
nexttile
plot(t900(401:427)*1000,x1(402:428));
title('x1: Lewis')
xlabel('t(ms)')
ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,x2(402:428));
title('x2: Duncan')
xlabel('t(ms)')
ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,y1(401:427));
% ylim([0 1600]);
title('y1')
xlabel('t(ms)')
ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,y2(401:427));
% ylim([0 1600]);
title('y2')
xlabel('t(m)')
ylabel('amplitude')

%% time series plots of bandpassed signals, overlay

figure('Name','time series overlays y1, y2')
tiledlayout(1,2)
nexttile
plot(t900(401:427)*1000,x1(402:428));
hold on;
plot(t(401:427)*1000,y1(401:427),'--r');
grid on;
title('x1,y1')
xlabel('t(m)')
ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,x2(402:428));
hold on;
plot(t900(401:427)*1000,y2(401:427),'--r');
grid on;
title('x2,y2')
xlabel('t(m)')
ylabel('amplitude')
%% plot in dBfigure('Name','x2 vs y2, dB')
