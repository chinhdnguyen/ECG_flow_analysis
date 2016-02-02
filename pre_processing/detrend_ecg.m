function detrended = detrend_ecg(x,fs,factor,plotflag)

% downsample by factor
xds = resample(x,1,factor);

% sampling rate of new signal
dfs = round(fs/factor);

% find trend by median filter
trend = fastmedfilt1d(xds,dfs*0.2);

% upsample
trend_rs = resample(trend,factor,1);

% find detrended signal
detrended = x - trend_rs;

if plotflag
    figure;
    h(1)=subplot(211);plot(x);hold on;plot(trend_rs,'-r');
    h(2)=subplot(212);plot(detrended);
    linkaxes(h,'x');
end
