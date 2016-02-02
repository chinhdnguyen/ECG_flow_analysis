function [HRV_result,IBI_result,CRS] = proc_Seg_HRV(ecg,fs,testmode)

%% HRV analysis
% Detect Rpeak using Gari Clifford script
threshold = 0.2;
[RRI, R_t, R_amp, R_index]  = rpeakdetect(ecg,fs,threshold,testmode);

% Analyse RRI
RRI = diff(R_index)./fs;
% RRI = diff(R_index);

HRV_result = HRV_analysis(RRI);

