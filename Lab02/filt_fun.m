function [sigfilt_fir1,sigfilt_fir5,sigfilt_iir1,sigfilt_iir5,...
    sigff_raw_fil,sigff_fir1_fil,sigff_iir1_fil, t_clip] ...
    = filt_fun(clipped,cutoff,Fs,fig_no,clip_text)
%FILT_FUN

% ORIGINAL
fft_orig = fft(clipped); % two-sided spectrum
fft_orig = fft_orig(1:floor(length(fft_orig)/2)+1); % clips to one-sided spectrum
fft_orig(2:end-1) = 2*fft_orig(2:end-1);

% FIRST ORDER
y = fir1(1,cutoff*2/Fs,'low');sigfilt_fir1 = filter(y,1,clipped);
[b1,a1] = butter(1,cutoff*2/Fs,'low');sigfilt_iir1 = filter(b1,a1,clipped);
t_clip = 0:1/Fs:length(clipped)/Fs; t_clip = t_clip(1:end-1);
figure(fig_no);subplot(2,2,1);plot(t_clip,clipped,t_clip,sigfilt_fir1,t_clip,sigfilt_iir1);
title(strcat("Comparison of Order 1 for ",clip_text));xlabel("Time [s]");ylabel("Signal");
legend("Original","FIR Filtered","IIR Filtered");

fft_fir1 = fft(sigfilt_fir1); % two-sided spectrum
fft_fir1 = fft_fir1(1:floor(length(fft_fir1)/2)+1); % clips to one-sided spectrum
fft_fir1(2:end-1) = 2*fft_fir1(2:end-1);

fft_iir1 = fft(sigfilt_iir1); % two-sided spectrum
fft_iir1 = fft_iir1(1:floor(length(fft_iir1)/2)+1); % clips to one-sided spectrum
fft_iir1(2:end-1) = 2*fft_iir1(2:end-1);

% FIRST ORDER - filtfilt.m
sigff_raw_fil = filtfilt(b1,a1,clipped);
sigff_fir1_fil = filtfilt(b1,a1,sigfilt_fir1);
sigff_iir1_fil = filtfilt(b1,a1,sigfilt_iir1);

% FIFTH ORDER
y = fir1(5,cutoff*2/Fs,'low');sigfilt_fir5 = filter(y,1,clipped);
[b1,a1] = butter(5,cutoff*2/Fs,'low');sigfilt_iir5 = filter(b1,a1,clipped);
figure(fig_no);subplot(2,2,2);plot(t_clip,clipped,t_clip,sigfilt_fir5,t_clip,sigfilt_iir5);
title(strcat("Comparison of Order 5 for ",clip_text));xlabel("Time [s]");ylabel("Signal");
legend("Original","FIR Filtered","IIR Filtered");

fft_fir5 = fft(sigfilt_fir5); % two-sided spectrum
fft_fir5 = fft_fir5(1:floor(length(fft_fir5)/2)+1); % clips to one-sided spectrum
fft_fir5(2:end-1) = 2*fft_fir5(2:end-1);

fft_iir5 = fft(sigfilt_iir5); % two-sided spectrum
fft_iir5 = fft_iir5(1:floor(length(fft_iir5)/2)+1); % clips to one-sided spectrum
fft_iir5(2:end-1) = 2*fft_iir5(2:end-1);

% SPECTRA
df = Fs/length(clipped); f_freq = (0:df:Fs/2);
figure(fig_no);subplot(2,2,3);plot(f_freq,abs(fft_orig),f_freq,abs(fft_fir1),f_freq,abs(fft_iir1)); 
title(strcat('Spectrum of ',clip_text,' for Order 1'));
xlabel('Frequency [Hz]');xlim([0 4000]);ylabel('Amplitude');
legend("Original","FIR Filtered","IIR Filtered");

figure(fig_no);subplot(2,2,4);plot(f_freq,abs(fft_orig),f_freq,abs(fft_fir5),f_freq,abs(fft_iir5)); 
title(strcat('Spectrum of ',clip_text,' for Order 5'));
xlabel('Frequency [Hz]');xlim([0 4000]);ylabel('Amplitude');
legend("Original","FIR Filtered","IIR Filtered");

%{
disp(clip_text);
disp("Original clip:");sound(clipped,Fs);pause
disp("FIR filtered clip of order 1:");sound(sigfilt_fir1,Fs);pause
disp("IIR filtered clip of order 1:");sound(sigfilt_iir1,Fs);pause
disp("FIR filtered clip of order 5:");sound(sigfilt_fir5,Fs);pause
disp("IIR filtered clip of order 5:");sound(sigfilt_iir5,Fs);disp(" ");
%}
end

