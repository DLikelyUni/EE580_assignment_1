%Assignment 1 - sem 2
% Lewis Carty
% Duncan Likely

clear;
u_1=[2,0,2,1,1,2,9,8,5];
u_2=[2,0,2,1,2,9,6,6,3];
x1=u_1;
x2=u_2;

for i=1:99 %Generate signal with length N=900 samples
    x1=[x1,u_1];
    x2=[x2,u_2];
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

%%
Hd1_hold=Hd1;
Hd2_hold=Hd2;
Hd1=single(Hd1.Numerator);
Hd2=single(Hd2.Numerator);
%%
figure(1)
zplane(Hd1_hold);
title('h_1[n]: Pole Zero - Pre-Quantization')

figure(2)
zplane(Hd1);
title('h_1[n]: Pole Zero - Quantized')

figure(3)
zplane(Hd2_hold);
title('h_2[n]: Pole Zero - Pre-Quantization')

figure(4)
zplane(Hd2);
title('h_2[n]: Pole Zero - Quantized')

%%
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
title('x_1[n]')
xlabel('t(ms)')
ylabel('amplitude')
nexttile
plot(t(1:27)*1000,x2(1:27));
title('x_2[n]')
xlabel('t(ms)')
ylabel('amplitude')

%% fft of original signals
figure(2)
tiledlayout(2,1)
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)));
% xlim([0 30]);
title('|fft X1|')
xlabel('f (Hz)')
ylabel('amplitude')
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)));
% xlim([0 30]);
title('|fft X2|')
xlabel('f(Hz)')
ylabel('amplitude')

%% Bandstop filtered signal x1[n]

figure('Name','x_1 vs y_1')
tiledlayout(2,1)
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)));
% ylim([0 1600]);
title('|fft X_1[n]|')
xlabel('f (Hz)')
ylabel('amplitude')
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y1)));
% ylim([0 1600]);
title('|fft Y_1[n]|')
xlabel('f(Hz)')
ylabel('amplitude')

%overlay x1 vs bandstop
figure('Name','x1 vs y1:overlay')
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X1)),'b');
hold on;
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y1)),'--r');
xlabel('f(Hz)')
ylabel('amplitude')
legend('|fft X_1|','|fft Y_1|')
title('X1 vs Y1, fd=705Hz')

%% Bandstop filtered signal x1[n]
figure('Name','x2 vs y2')
tiledlayout(2,1)
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)));
% ylim([0 1600]);
title('|fft X_2|')
xlabel('f (Hz)')
ylabel('dB')
nexttile
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y2)));
% ylim([0 1600]);
title('|fft Y_2|')
xlabel('f(Hz)')
ylabel('amplitude')

%overlay x2 vs bandstop
figure('Name','x2 vs y2:overlay')
plot(fs/L*(-L/2:L/2-1),abs(fftshift(X2)),'b');
hold on;
plot(fs/L*(-L/2:L/2-1),abs(fftshift(Y2)),'--r');
xlabel('f(Hz)')
ylabel('amplitude')
legend('|fft X_2|','|fft Y_2|')
title('X_2 vs Y_2, fd=2810Hz')

%% time series plots of bandpassed signals
figure('Name','time series y1, y2')
tiledlayout(2,1)
% nexttile
% plot(t900(401:427)*1000,x1(402:428));
% title('x_1')
% xlabel('t(ms)')
% ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,x2(402:428));
title('x_2')
xlabel('t(ms)')
ylabel('amplitude')
% nexttile
% plot(t900(401:427)*1000,y1(401:427));
% % ylim([0 1600]);
% title('y_1')
% xlabel('t(ms)')
% ylabel('amplitude')
nexttile
plot(t900(401:427)*1000,y2(401:427));
% ylim([0 1600]);
title('y_2')
xlabel('t(m)')
ylabel('amplitude')

%% time series plots of bandpassed signals, overlay

figure('Name','time series overlays y1, y2')
% tiledlayout(1,2)
% nexttile
% plot(t900(401:427)*1000,x1(402:428));
% hold on;
% plot(t(401:427)*1000,y1(401:427),'--r');
% grid on;
% title('x_1 vs y_1')
% legend('x_1[n]','y_1[n]')
% xlabel('t(ms)')
% ylabel('amplitude')
% nexttile
plot(t900(401:427)*1000,x2(402:428));
hold on;
plot(t900(401:427)*1000,y2(401:427),'--r');
grid on;
title('x_2[n] vs y_2[n]')
legend('x_2[n]','y_2[n]')
xlabel('t(ms)')
ylabel('amplitude')
%% plot in dBfigure('Name','x2 vs y2, dB')
