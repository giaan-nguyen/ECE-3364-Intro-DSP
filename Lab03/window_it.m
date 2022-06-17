function [overlapped_matr,fft_matr,n_val,delta_t] = window_it(audio_recording,dur_aud,time_vec,overlap_in_ms,window_method)

overlap_in_s = overlap_in_ms/1000;
delta_t = dur_aud/length(time_vec);window_length = floor(overlap_in_s/delta_t);
overlapped_matr = buffer(audio_recording,window_length,floor(window_length/2));
if window_method == 2
    w = hamming(length(overlapped_matr(:,1)));
    y = repmat(w,1,length(overlapped_matr(1,:))) .* overlapped_matr;
    overlapped_matr = y;
end
fft_matr = fft(overlapped_matr);
num_wind = floor(length(time_vec)/window_length);
[nrow n_val] = size(fft_matr);

end

