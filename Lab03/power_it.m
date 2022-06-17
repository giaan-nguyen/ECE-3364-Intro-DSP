function [] = power_it(n_vec,fft_matr,fig_no,sub_no)
% welch's method
ave_periodo = mean(abs(fft_matr).^2/(length(n_vec)));
figure(fig_no);subplot(2,4,sub_no);
power_spec = 10*log10(ave_periodo);
plot(n_vec,power_spec);
xlabel('Time [s]');ylabel('Power [dB]');

end

