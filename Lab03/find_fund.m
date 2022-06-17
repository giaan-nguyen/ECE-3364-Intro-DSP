function [] = find_fund()
% Load in file
[FileName,PathName]=uigetfile({'*.mp3';'*.m4a';'*.wma'},'File Selector');
FullPath = strcat(PathName,FileName);
[recording,Fs] = audioread(FullPath);
[dur_aud,time_vec,data_vec] = initialize_audio(recording, Fs);

% Use Welch's method to extract where max PSD is
[overlapped_matr,fft_matr,n_val,delta_t] = window_it(data_vec,dur_aud,time_vec,400,2);
ave_periodo = mean(abs(fft_matr).^2/(length(fft_matr(1,:))));
power_spec = 10*log10(ave_periodo);
n_vec = linspace(0,dur_aud,n_val);
figure(10);plot(n_vec,power_spec);
[max_peak peak_index] = max(power_spec);
approx_peak_time = n_vec(peak_index);buff = 0.5;
tmin = approx_peak_time - buff; tmax = approx_peak_time + buff; 

% Clip data signal to where max PSD is
time_clipped = time_vec(time_vec > tmin & time_vec < tmax); 
index = find(time_vec == time_clipped(1));
data_clipped = data_vec(index:(index + length(time_clipped) - 1));

% FFT with Hamming window
%data_clipped = data_vec;
L = length(data_clipped);
N = max(L,2^ceil(log2(L)));
if N > L
    diff_size = N - L;
    for i = 1:diff_size
       data_clipped(end+1) = 0; % zero-padding 
    end
end
data_windowed = data_clipped .* hamming(N);
f_fft = fft(data_windowed); % two-sided spectrum
f_fft = f_fft(1:floor(length(f_fft)/2)+1); % clips to one-sided spectrum
f_fft(2:end-1) = 2*f_fft(2:end-1);
df = Fs/length(data_windowed); f_freq = (0:df:Fs/2);
figure(11);plot(f_freq,abs(f_fft).^2/length(f_fft));xlim([0 1000]);

% Clip front end so that 80<f<300 (for human)
f_clipped = f_freq(f_freq > 80 & f_freq < 300); 
fmin = find(f_freq == f_clipped(1));fmax = find(f_freq == f_clipped(end));
fft_clipped = f_fft(fmin:fmax);

fpeak = max(abs(fft_clipped));
floc = find(abs(fft_clipped) == fpeak);
fund_freq = f_clipped(floc);
disp(strcat("The fundamental frequency is ",num2str(fund_freq)));
end

