function [data_clipped, f_fft] = fft_recording(time_vec,data_vec,tmin,tmax,Fs,fig_no,sub_no,fig_text,min_peak_dist,min_peak_height,f_max_view)
    time_clipped = time_vec(time_vec > tmin & time_vec < tmax); 
    index = find(time_vec == time_clipped(1));
    data_clipped = data_vec(index:(index + length(time_clipped) - 1));
    %{
    figure(fig_no+4);subplot(2,2,sub_no);plot(time_clipped,data_clipped);
    title(fig_text);xlabel('Time [sec]');ylabel('Signal');
    %}

    f_fft = fft(data_clipped); % two-sided spectrum
    f_fft = f_fft(1:floor(length(f_fft)/2)+1); % clips to one-sided spectrum
    f_fft(2:end-1) = 2*f_fft(2:end-1);
    df = Fs/length(data_clipped); f_freq = (0:df:Fs/2);
    [f_pks f_locs] = findpeaks(abs(f_fft),f_freq,'MinPeakDistance',min_peak_dist,'MinPeakHeight',min_peak_height);
    nf_locs = [];nf_pks = []; 
    for n=1:length(f_locs)
        if f_locs(n) <= f_max_view
            nf_locs = [nf_locs f_locs(n)];
            nf_pks = [nf_pks f_pks(n)];
        end
    end
    figure(fig_no);subplot(2,2,sub_no);plot(f_freq,abs(f_fft),nf_locs,nf_pks,'o'); 
    title(strcat('Spectrum of ',fig_text));
    xlabel('Frequency [Hz]');ylabel('Amplitude');xlim([0 f_max_view]);
    for i = 1:length(nf_pks)
        text(nf_locs(i), nf_pks(i), sprintf('%.2f', round(nf_locs(i),2)),'FontSize',10)
    end
    
end

