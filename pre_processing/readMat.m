function [ECG,Flow,fs,file] = readMat()
% read matfile and get ECG, Flow traces, resample to max fs

[file,path] = uigetfile('Select mat-file to analyse');
cd(path);

% load signal
ECG = load(file,'ECG1');
ECG = ECG.ECG1;

Flow = load(file,'Thor');
Flow = Flow.Thor;

Flow1 = load(file,'Abdo');
Flow1 = Flow1.Abdo;

Flow2 = load(file,'rescFlow');
Flow2 = Flow2.rescFlow;
if isempty(Flow2)
    Flow2 = load(file,'Flow');
    Flow2 = Flow2.Flow;
end

maxL=max([length(ECG),length(Flow),length(Flow1),length(Flow2)]);
fs = load(file,'fs');fs = fs.fs;
fs = max(fs);

% resample
ECG = resample(ECG,round(maxL/length(ECG)),1);
Flow = resample(Flow,round(maxL/length(Flow)),1);

% low pass filter flow signal
lf = 2;
Flow = normalize(Flow);
Flow = zerophase_lowpass(Flow,lf,fs);

