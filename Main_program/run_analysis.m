function [result,HRV_result,IBI_result,CRS_result] = run_analysis(winL,winOverLap)

% winL = 0.5;
% winOverLap = winL-0.5;

% read file
[ECG,Flow,fs,file] = readMat();

% segmentize 
[ECGseg,Flowseg,indseg] = segData(ECG,Flow,fs,winL,winOverLap);

% process data
[Index,HRV_result,IBI_result,CRS_result] = proc_Data(ECGseg,Flowseg,indseg,fs);

% save result to CSV
display('Saving to CSV file. Please wait....');
result = save2csv(Index,HRV_result,IBI_result,CRS_result,file);