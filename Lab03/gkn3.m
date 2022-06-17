%{
    Giaan Nguyen
    ECE 3366 - Lab 03
    Due: Friday, Nov. 22, 2019 @ 11:59pm
%}
clc, clear all

%% Part 1
% Load in audio
% Female 1
[giaan_female1_recording Fs_f1] = audioread('giaannguyen_female1.m4a');
[duration_f1 time_f1 data_f1] = initialize_audio(giaan_female1_recording, Fs_f1);
% Female 2
[giaan_female2_recording Fs_f2] = audioread('giaannguyen_female2.mp3');
[duration_f2 time_f2 data_f2] = initialize_audio(giaan_female1_recording, Fs_f2);
% Male 1 - REMINDER: he made an "e-i-e-i ... -o" joke and flipped the order
% of the second and third artifact
[giaan_male1_recording Fs_m1] = audioread('giaannguyen_male1.mp3');
[duration_m1 time_m1 data_m1] = initialize_audio(giaan_female1_recording, Fs_m1);
% Male 2
[giaan_male2_recording Fs_m2] = audioread('giaannguyen_male2.m4a');
[duration_m2 time_m2 data_m2] = initialize_audio(giaan_female1_recording, Fs_m2);

%% Window segments and slide, then plot Welch's periodogram
% window method: 1 for rect, 2 for hamming
wind_pow(data_f1,duration_f1,time_f1,1,1);
wind_pow(data_f2,duration_f2,time_f2,2,1);
wind_pow(data_m1,duration_m1,time_m1,3,1);
wind_pow(data_m2,duration_m2,time_m2,4,1);

wind_pow(data_f1,duration_f1,time_f1,1,2);
wind_pow(data_f2,duration_f2,time_f2,2,2);
wind_pow(data_m1,duration_m1,time_m1,3,2);
wind_pow(data_m2,duration_m2,time_m2,4,2);

%% Spectrograms
%{
spectro(data_f1,duration_f1,time_f1,9);
spectro(data_f2,duration_f2,time_f2,10);
spectro(data_m1,duration_m1,time_m1,11);
spectro(data_m2,duration_m2,time_m2,12);
%}

%% Part 2 - Find fund freq
find_fund()

%% Part 3 - Downsample
down_f1 = decimate(data_f1,8);time_f1 = downsample(time_f1,8);
down_f2 = decimate(data_f2,8);time_f2 = downsample(time_f2,8);
down_m1 = decimate(data_m1,8);time_m1 = downsample(time_m1,8);
down_m2 = decimate(data_m2,8);time_m2 = downsample(time_m2,8);

wind_pow(down_f1,duration_f1,time_f1,5,1);
wind_pow(down_f2,duration_f2,time_f2,6,1);
wind_pow(down_m1,duration_m1,time_m1,7,1);
wind_pow(down_m2,duration_m2,time_m2,8,1);

wind_pow(down_f1,duration_f1,time_f1,5,2);
wind_pow(down_f2,duration_f2,time_f2,6,2);
wind_pow(down_m1,duration_m1,time_m1,7,2);
wind_pow(down_m2,duration_m2,time_m2,8,2);