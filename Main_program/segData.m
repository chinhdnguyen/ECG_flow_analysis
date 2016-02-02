function [ECGseg,Flowseg,indseg] = segData(ECG,Flow,fs,winL,winOverLap)

%winL: length of running windows (in minute)
%winOverLap: length of overlap windows (in minute)
winL = winL*60*fs;
winOverLap = winOverLap*60*fs;

maxL=max([length(ECG),length(Flow)]);

ind = 1:maxL; %index
t = ind/fs; %time
% tepoch = (1:30*fs:maxL)/fs;

ECGseg = buffer(ECG,winL,winOverLap);
Flowseg = buffer(Flow,winL,winOverLap);
indseg = buffer(ind,winL,winOverLap);
