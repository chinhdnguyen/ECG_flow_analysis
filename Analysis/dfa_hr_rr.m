function [H, F, scale] = dfa_hr_rr(signal,scmin,scmax,scres,plotflag)
% Detrended fluctuation analysis (DFA). This Matlab function
% calculate DFA from input signal.
%
% [F, scale, H] = dfa_c(signal,scmin,scmax,scres)
%
% INPUT PARAMETERS---------------------------------------------------------
%
% signal:       input signal
% scmin:        scale min (start point) 
% scmax:        scale max (end point)
% scres:        scale resolution (number of points in the scale)
%
% OUTPUT VARIABLES---------------------------------------------------------
%
% F:            fluctation function value F(n)
% scale:        scale, n points 
% H:            Hurst exponent
%
% EXAMPLE------------------------------------------------------------------
%
% [F,n,H] = dfa_c(signal,10,512,20);
%--------------------------------------------------------------------------
% Created 14 July 2014 by C.Nguyen 
% Based on the paper Introduction to multifractal detrended fluctation
% analysis in matlab, Ihlen, 2012, frontiers in Physiology
warning off;

X=cumsum(signal-mean(signal));
X=transpose(X);

exponents=linspace(log2(scmin),log2(scmax),scres);
scale=round(2.^exponents);
scale = unique(scale);
% detrending parameter m 
% the polynomial trend is 
% linear if m = 1;
% quadratic if m = 2;
% cubic if m = 3;
m=1;

% initialize
segments = zeros(length(scale),1);
F = zeros(1,length(scale));

% calculate F(n) for each n
for ns=1:length(scale)
    % find number of segments
    segments(ns)=floor(length(X)/scale(ns));
    
    %initialize Index
    Index = cell(length(segments),length(scale));
    fit = cell(length(segments),length(scale));
    RMS = cell(1,length(scale));
    
    % with each segment
    for v=1:segments(ns)
        % find start and stop point
        Idx_start=((v-1)*scale(ns))+1;
        Idx_stop=v*scale(ns);
        
        % index and find corresponding signal
        Index{v,ns}=Idx_start:Idx_stop;
        X_Idx=X(Index{v,ns});
        
        % create polynomial trend of each segment
        % find coefficient C for the fitting
        C=polyfit(Index{v,ns},X(Index{v,ns}),m);
        fit{v,ns}=polyval(C,Index{v,ns});
        
        % find residual variance in each segment
        RMS{ns}(v)=sqrt(mean((X_Idx-fit{v,ns}).^2));
    end
    
    % calculate root mean square 
    F(ns)=sqrt(mean(RMS{ns}.^2));
end

C = polyfit(log2(scale),log2(F),1);
% C = fitnan(log2(scale),log2(F),1);
H = C(1);

RegLine = polyval(C,log2(scale));

if plotflag
    figure;
    hold on;
    plot(log2(scale),log2(F),'or');
    hold on;
    plot(log2(scale),RegLine);
    str = sprintf('Alpha = %d',H);
    title(str);
end


