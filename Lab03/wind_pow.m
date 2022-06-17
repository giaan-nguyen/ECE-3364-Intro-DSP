function [] = wind_pow(audio_recording,dur_aud,time_vec,fig_no,window_method)
% window method: 1 for rect, 2 for hamming
overlap_in_ms = [50, 100, 200, 400];
for i=1:4
    [overlapped_matr fft_matr n_val delta_t] = window_it(audio_recording,dur_aud,time_vec,overlap_in_ms(i),window_method);
    n_vec = linspace(0,dur_aud,n_val);
    if window_method == 1
        power_it(n_vec,fft_matr,fig_no,i);
    else if window_method == 2
            power_it(n_vec,fft_matr,fig_no,i+4);
        end
    end
    title_sub = strcat(num2str(overlap_in_ms(i)),'-ms window');
    title(title_sub);
end
end

