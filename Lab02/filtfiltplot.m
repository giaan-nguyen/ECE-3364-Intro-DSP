function [] = filtfiltplot(raw_fil,fir_fil,iir_fil,time_vec,clip_text,fig_no,sub_no,Fs)
%FILTFILTPLOT 

figure(fig_no);
subplot(2,2,sub_no);plot(time_vec,raw_fil,time_vec,fir_fil,time_vec,iir_fil);
title(strcat("Filtfilt Applied to ",clip_text));
xlabel("Time [s]");ylabel("Signal");legend("Raw Data","FIR Data","IIR Data")

disp(clip_text);
disp("Raw data filtered:");sound(raw_fil,Fs);pause
disp("FIR data filtered:");sound(fir_fil,Fs);pause
disp("IIR data filtered:");sound(iir_fil,Fs);disp(" ");pause

end

