function [out] = HRV_analysis(rri)

% define data window
data = rri; % RR interval
datat = cumsum(rri); % time of RR interval
%% basic stats
% average heart rate
meanNN=mean(data);
N=length(data);
% SD (not strictly the SDNN!
SDNN = std(data);
RMSSD    = rms(diff(data));  % SDSD
NN50count  = sum(abs(diff(data))>0.050);
pNN50    = NN50count/N;

%% frequency analysis
% for Lomb periodogram
freq_vect =  1/1024 : 1/1024 : 512 * 1/1024;
% PSD using unevenly sampled technique
Px = lomb(datat, data-mean(data), freq_vect);

% calculate the LF/HF ratio and the LF and HF (not normalised values)
[LFHF, LF, HF, LFnu, HFnu] =  calc_lfhf(freq_vect,Px);


%% DFA %
% if length(NN)<150
%     display('Length RR internval < 150!');
% else
resol = 10;
minL = 4;
maxL = round(length(data)/4);
plotflag = 0;
if length(data)>100
    alpha = dfa_hr_rr(data',minL,maxL,resol,plotflag);
else
    alpha = NaN;
end
% end

%% Poincare analysis
% Poincare analysis
plotflag = 0;
normalizeflag = 1;
[SD1,SD2,SD1_SD2] = poincare_IBI(data,1,plotflag,normalizeflag);


%% output
out.NumRRI = N;
out.meanNN = meanNN';
out.SDNN = SDNN';
out.RMSSD = RMSSD';
out.pNN50 = pNN50';
out.SD1 = SD1';
out.SD2 = SD2';
out.SD1_SD2 = SD1_SD2';
out.LF = LF';
out.HF = HF';
out.LFHFratio = LFHF';
out.LFnu = LFnu';
out.HFnu = HFnu';
out.alpha = alpha';