function [HRV_result,IBI_result,CRS] = proc_Seg(ecg,flow,ind,fs,m)

%% HRV analysis
% Detect Rpeak using Gari Clifford script
threshold = 0.2;
testmode=0;
[RRI, R_t, R_amp, R_index]  = rpeakdetect(ecg,fs,threshold,testmode);

% Analyse RRI
RRI = diff(R_index)./fs;
% RRI = diff(R_index);

HRV_result = HRV_analysis(RRI);

%% Respiratory analysis
% Get IBI from flow signal
[IBI,cumm_phase,breath_index] = get_IBI_flow(flow,fs);

% Analyse IBI
IBI_result = respiratory_analysis(IBI);

%% CRS analysis
ratio = countRR_eachBreath(R_index,breath_index);
[lambda,Lnorm] = CRS_analysis(R_index,cumm_phase,ratio);
CRS.lambda = lambda';
CRS.Lnorm = Lnorm';
