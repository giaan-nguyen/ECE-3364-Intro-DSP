%{
    Giaan Nguyen
    ECE 3366 - Lab 01
    Due: Friday, Sept. 27, 2019 @ 11:59pm
%}
clc, clear all

%% Part 1
% Female 1
[giaan_female1_recording Fs_f1] = audioread('giaannguyen_female1.m4a');
[video_f1] = audioinfo('giaannguyen_female1.m4a');
%sound(giaan_female1_recording,Fs);
duration_f1 = length(giaan_female1_recording)/Fs_f1;
time_f1 = 0:1/Fs_f1:duration_f1; time_f1 = time_f1(1:end-1);
data_f1 = giaan_female1_recording(:,1);
figure(1);subplot(2,2,1);plot(time_f1,data_f1);
title('Female 1 Recording');xlabel('Time [sec]');ylabel('Signal');

% Female 2
[giaan_female2_recording Fs_f2] = audioread('giaannguyen_female2.mp3');
[video_f2] = audioinfo('giaannguyen_female2.mp3');
%sound(giaan_female2_recording,Fs);
duration_f2 = length(giaan_female2_recording)/Fs_f2;
time_f2 = 0:1/Fs_f2:duration_f2; time_f2 = time_f2(1:end-1);
data_f2 = giaan_female2_recording(:,1);
subplot(2,2,2);plot(time_f2,data_f2);
title('Female 2 Recording');xlabel('Time [sec]');ylabel('Signal');

% Male 1
[giaan_male1_recording Fs_m1] = audioread('giaannguyen_male1.mp3');
[video_m1] = audioinfo('giaannguyen_male1.mp3');
%sound(giaan_male1_recording,Fs);
duration_m1 = length(giaan_male1_recording)/Fs_m1;
time_m1 = 0:1/Fs_m1:duration_m1; time_m1 = time_m1(1:end-1);
data_m1 = giaan_male1_recording(:,1);
subplot(2,2,3);plot(time_m1,data_m1);
title('Male 1 Recording');xlabel('Time [sec]');ylabel('Signal');

% Male 2
[giaan_male2_recording Fs_m2] = audioread('giaannguyen_male2.m4a');
[video_m2] = audioinfo('giaannguyen_male2.m4a');
%sound(giaan_male2_recording,Fs);
duration_m2 = length(giaan_male2_recording)/Fs_m2;
time_m2 = 0:1/Fs_m2:duration_m2; time_m2 = time_m2(1:end-1);
data_m2 = giaan_male2_recording(:,1);
subplot(2,2,4);plot(time_m2,data_m2);
title('Male 2 Recording');xlabel('Time [sec]');ylabel('Signal');

%% Part 2 - Female 1
% sip
[fsip_clip1 fft_sip_f1] = fft_recording(time_f1,data_f1,0.8,1.15,Fs_f1,2,1,'Female 1 "Sip"',160,20,4000);
% nip
[fnip_clip1 fft_nip_f1] = fft_recording(time_f1,data_f1,5.9,6.15,Fs_f1,3,1,'Female 1 "Nip"',100,35,4000);
% rip
[frip_clip1 fft_rip_f1] = fft_recording(time_f1,data_f1,11.2,11.45,Fs_f1,4,1,'Female 1 "Rip"',100,45,4000);
% iaia
[fia_clip1 fft_ia_f1] = fft_recording(time_f1,data_f1,15.75,17.9,Fs_f1,5,1,'Female 1 "i a i a"',100,100,3000);

%% Part 2 - Female 2
% sip
[fsip_clip2 fft_sip_f2] = fft_recording(time_f2,data_f2,1.25,1.93,Fs_f2,2,2,'Female 2 "Sip"',200,45,4000);
% nip
[fnip_clip2 fft_nip_f2] = fft_recording(time_f2,data_f2,7.95,8.55,Fs_f2,3,2,'Female 2 "Nip"',200,77,4000);
% rip
[frip_clip2 fft_rip_f2] = fft_recording(time_f2,data_f2,13.75,14.36,Fs_f2,4,2,'Female 2 "Rip"',100,75,4000);
% iaia
[fia_clip2 fft_ia_f2] = fft_recording(time_f2,data_f2,18.9,21.25,Fs_f2,5,2,'Female 2 "i a i a"',200,100,3000);

%% Part 2 - Male 1
% NOTE: this person flipped the order of nip and sip
% sip
[msip_clip1 fft_sip_m1] = fft_recording(time_m1,data_m1,0.6,1.46,Fs_m1,2,3,'Male 1 "Sip"',100,35,4000);
% nip
[mnip_clip1 fft_nip_m1] = fft_recording(time_m1,data_m1,10.65,11.55,Fs_m1,3,3,'Male 1 "Nip"',100,35,4000);
% rip
[mrip_clip1 fft_rip_m1] = fft_recording(time_m1,data_m1,5.78,6.65,Fs_m1,4,3,'Male 1 "Rip"',100,35,4000);
% iaia
[mia_clip1 fft_ia_m1] = fft_recording(time_m1,data_m1,15.87,17.65,Fs_m1,5,3,'Male 1 "i a i a"',200,100,3000);

%% Part 2 - Male 2

% sip
[msip_clip2 fft_sip_m2] = fft_recording(time_m2,data_m2,1.2,1.82,Fs_m2,2,4,'Male 2 "Sip"',200,50,4000);
% nip
[mnip_clip2 fft_nip_m2] = fft_recording(time_m2,data_m2,6.47,7.83,Fs_m2,3,4,'Male 2 "Nip"',100,70,4000);
% rip
[mrip_clip2 fft_rip_m2] = fft_recording(time_m2,data_m2,11.8,12.57,Fs_m2,4,4,'Male2 "Rip"',100,100,4000);
% iaia
[mia_clip2 fft_ia_m2] = fft_recording(time_m2,data_m2,16.95,19.4,Fs_m2,5,4,'Male 2 "i a i a"',200,100,3000);
