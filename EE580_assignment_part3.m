%EE580 assignment 1 read in and compare
clear;clc;
y1=read_txt('signal_y1.txt');%Read in output of matlab filter implementation 1
y2=read_txt('signal_y2.txt');%Read in output of matlab filter implementation 2

%% Plots

%Time plot
figure()
tiledlayout(2,1)
nexttile
timeplot_3(y1,"y1")
nexttile
timeplot_3(y2,"y2")

%frequency plot
figure()
tiledlayout(2,1)
nexttile
freqplot(y1,"Y1")
nexttile
freqplot(y2,"Y2")


%% function definitions
function timeplot_3(sig,signame)
    fs=6324; %sampling frequency
    t900 = ((0:900-1)*(1/fs));%900 time stamps
    plot(t900(401:427)*1000,sig(401:427),'--r','LineWidth',2);
    grid on;
    title(signame+"[n] vs time")
    xlabel('t(ms)')
    ylabel('amplitude')

end

function freqplot(sig,signame)
    fs=6324; L=1024;%sampling frequency/fft ;lenth
    sig_fft=fft(sig,L);%1024 point Fast Fourier transform of signal
    tickx=(0:200:3000);
    ticky=(0:100:1600);
    plot(fs/L*(-L/2:L/2-1),abs(fftshift(sig_fft)));
    hold on;
    xlim([0 3000]);
    title("|fft "+ signame+"|")
    xlabel('f (Hz)')
    ylabel('amplitude')
    xticks(tickx);
    yticks(ticky);
    grid on
    set(gca,'XMinorGrid','on');
end

function sigread=read_txt(filename)
    fileID = fopen(filename,'r'); %open file to read
    formatSpec = '%f'; % Define data format %f - floating point
    sigread = fscanf(fileID,formatSpec);% read file data to column vector A and apply format spec
    fclose(fileID); % Close the file after reading
end
