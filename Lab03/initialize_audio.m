function [duration_samp,time_samp,data_samp] = initialize_audio(audio_samp, Fs)

duration_samp = length(audio_samp)/Fs;
time_samp = 0:1/Fs:duration_samp; time_samp = time_samp(1:end-1);
data_samp = audio_samp(:,1);

end

