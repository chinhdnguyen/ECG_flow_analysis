function [SD1,SD2,SD1_SD2,X,Y] = poincare_IBI(series,tau,plotflag,normalizeflag)
%
[r,c] = size(series);
% series = series(~isnan(series));
if r<c
    series = series';
end

x = series;

%normalize y
if normalizeflag
    x = nannormalize(x);
%         x = nan_mean_normalize(x);
end

X = x(1:end-tau);
Y = x(1+tau:end);

SD1 = sqrt(2)*nanstd(X-Y)/2;
SD2 = sqrt(2*(nanstd(X))^2-1/2*(nanstd(X-Y))^2);
SD1_SD2 = SD1/SD2;

SD1 = real(SD1);
SD2 = real(SD2);
SD1_SD2 = real(SD1_SD2);

if plotflag
    figure;
    plot(X,Y,'o','MarkerSize',5);
end