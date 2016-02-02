function X = respiratory_analysis(IBI)

% basic statistics
X.N_IBI = length(IBI)';
X.meanIBI = mean(IBI)';
X.SDIBI = std(IBI)';
X.CVIBI = (X.SDIBI/X.meanIBI)';
X.freqIBI = (1/X.meanIBI*60)'; %bpm

% Poincare analysis
plotflag = 0;
normalizeflag = 1;
[X.SD1_IBI,X.SD2_IBI,X.SD1_SD2_IBI] = poincare_IBI(IBI,1,plotflag,normalizeflag);

X.SD1_IBI = X.SD1_IBI';
X.SD2_IBI = X.SD2_IBI';
X.SD1_SD2_IBI = X.SD1_SD2_IBI';
% DFA
% if length(NN)<150
%     display('Length RR internval < 150!');
% else
resol = 10;
minL = 4;
maxL = round(length(IBI)/4);
plotflag = 0;

if length(IBI)>100
    X.alphaIBI = dfa_hr_rr(IBI,minL,maxL,resol,plotflag);
else
    X.alphaIBI = NaN;
end

X.alphaIBI = X.alphaIBI';