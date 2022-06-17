%{
    Giaan Nguyen
    ECE 3366 - Lab 02
    Due: Monday, Oct. 21, 2019 @ 11:59pm
%}
clc, clear all

%% Part A
time_vec = 0:0.001:0.1;
arb_freq = 150; arb_cutoff = 3*arb_freq; arb_samp = 44100;
square_wave = square(2*pi*arb_freq*time_vec);
figure(1);plot(time_vec,square_wave);title("Square Wave");xlabel("Time");ylabel("Signal")

% Freq Resp of FIR
filt_order = [1,2,3,4,5,10,15,20];
for i = 1:length(filt_order) % to view only orders 1-5, change to i=1:5
    y = fir1(filt_order(i),arb_cutoff*2/arb_samp,'low');
    str_filt(i) = sprintf("Order %d",filt_order(i));
    figure(2);freqz(y,1,512);hold on
end
lines = findall(gcf,'type','line');
color_line = ["r","g","b","c","m","#7E2F8E","#D95319","k"];
for i = 1:length(filt_order)
    lines(i).Color = color_line(i);
    hold on;
end
legend(str_filt(1),str_filt(2),str_filt(3),str_filt(4),str_filt(5),...
    str_filt(6),str_filt(7),str_filt(8),'Location','southwest')
hold off

% Using FIR on square wave
for i = 1:length(filt_order)
    sigfilt_fir(i,:) = filter(fir1(filt_order(i),arb_cutoff*2/arb_samp,'low'),1,square_wave);
    figure(3);plot(time_vec,sigfilt_fir(i,:));hold on
end
title("FIR-Filtered Square Wave");xlabel("Time");ylabel("Signal");legend(str_filt);hold off

% Freq Resp of IIR Butterworth
for i = 1:length(filt_order)
    [b1,a1] = butter(filt_order(i),arb_cutoff*2/arb_samp,'low');
    figure(4);freqz(b1,a1,512);hold on
end
lines = findall(gcf,'type','line');
color_line = ["r","g","b","c","m","#7E2F8E","#D95319","k"];
for i = 1:length(filt_order)
    lines(i).Color = color_line(i);
    hold on;
end
legend(str_filt(1),str_filt(2),str_filt(3),str_filt(4),str_filt(5),...
    str_filt(6),str_filt(7),str_filt(8),'Location','southwest')
hold off

% Using IIR on Square Wave
for i = 1:length(filt_order)
    [b1,a1] = butter(filt_order(i),arb_cutoff*2/arb_samp,'low');
    sigfilt_iir(i,:) = filter(b1,a1,square_wave);
    figure(5);plot(time_vec,sigfilt_iir(i,:));ylim([-1 1]);hold on
end
title("IIR-Filtered Square Wave");xlabel("Time");ylabel("Signal");legend(str_filt);hold off

% Compare plots
figure(6);plot(time_vec,square_wave,time_vec,sigfilt_fir(1,:),time_vec,sigfilt_iir(1,:));
title('Square Wave Comparisons (Order 1)');xlabel('Time');ylabel('Signal');legend('Original','FIR Filtered','IIR Filtered');

figure(7);plot(time_vec,square_wave,time_vec,sigfilt_fir(5,:),time_vec,sigfilt_iir(5,:));
title('Square Wave Comparisons (Order 5)');xlabel('Time');ylabel('Signal');legend('Original','FIR Filtered','IIR Filtered');
disp("Press enter to clear all and proceed.");pause

%% Part B
clc, clear all
[giaan_male1_recording Fs_m1] = audioread('giaannguyen_male1.mp3');
duration_m1 = length(giaan_male1_recording)/Fs_m1;
time_m1 = 0:1/Fs_m1:duration_m1; time_m1 = time_m1(1:end-1);
data_m1 = giaan_male1_recording(:,1);

% NOTE: this person flipped the order of nip and sip
% sip
[msip_clip1 fft_sip_m1 freq_sip_m1] = fft_recording(time_m1,data_m1,0.6,1.46,Fs_m1,1,1,'Male 1 "Sip"',100,35,4000);
cutoff = 200;
[sip_fir1 sip_fir5 sip_iir1 sip_iir5 sip_ff_raw_fil sip_ff_fir_fil sip_ff_iir_fil sip_time] = filt_fun(msip_clip1,cutoff,Fs_m1,2,"sip");

% nip
[mnip_clip1 fft_nip_m1 freq_nip_m1] = fft_recording(time_m1,data_m1,10.65,11.55,Fs_m1,1,2,'Male 1 "Nip"',100,35,4000);
[nip_fir1 nip_fir5 nip_iir1 nip_iir5 nip_ff_raw_fil nip_ff_fir_fil nip_ff_iir_fil nip_time] = filt_fun(mnip_clip1,cutoff,Fs_m1,3,"nip");

% rip
[mrip_clip1 fft_rip_m1 freq_rip_m1] = fft_recording(time_m1,data_m1,5.78,6.65,Fs_m1,1,3,'Male 1 "Rip"',100,35,4000);
[rip_fir1 rip_fir5 rip_iir1 rip_iir5 rip_ff_raw_fil rip_ff_fir_fil rip_ff_iir_fil rip_time] = filt_fun(mrip_clip1,cutoff,Fs_m1,4,"rip");

% iaia
[mia_clip1 fft_ia_m1 freq_ia_m1] = fft_recording(time_m1,data_m1,15.87,17.65,Fs_m1,1,4,'Male 1 "i a i a"',200,100,3000);
[ia_fir1 ia_fir5 ia_iir1 ia_iir5 ia_ff_raw_fil ia_ff_fir_fil ia_ff_iir_fil ia_time] = filt_fun(mia_clip1,cutoff,Fs_m1,5,"iaia");
disp("Press enter to close all figures and continue.");pause

%% Part C
clc, close all
% filtfilt is included in filt_fun.m (for order 1)
filtfiltplot(sip_ff_raw_fil,sip_ff_fir_fil,sip_ff_iir_fil,sip_time,"sip",6,1,Fs_m1);
filtfiltplot(nip_ff_raw_fil,nip_ff_fir_fil,nip_ff_iir_fil,nip_time,"nip",6,2,Fs_m1);
filtfiltplot(rip_ff_raw_fil,rip_ff_fir_fil,rip_ff_iir_fil,rip_time,"rip",6,3,Fs_m1);
filtfiltplot(ia_ff_raw_fil,ia_ff_fir_fil,ia_ff_iir_fil,ia_time,"iaia",6,4,Fs_m1);