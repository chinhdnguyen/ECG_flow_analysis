function x_filt = zerophase_lowpass(x,lf,fs)

% filter flow
N = 2; % the higher the sharper the peak is
% length = 1s (cut off frequency = 0.965 Hz)
% Refer. Schafer, 2011, What is S-G filter.
% fc_n = (N+1)/(3.2M - 4.6) (normalized unit)
% fc(Hz) = fc_n*fs/2;
% N: order: M length;
% fc=lf(Hz) -> fc_n = 2*lf/fs;
% M = [(N+1)*fs/(2*lf)+4.6]/3.2;

% l_lfilter = round(fs*lf); % the longer, the smoother
% l_lfilter = round(fs*lf); % the longer, the smoother
l_lfilter = round(((N+1)*fs/(2*lf)+4.6)/3.2);
if ~mod(l_lfilter,2)
    l_lfilter = l_lfilter + 1;
end
% filter flow signal
x_filt = sgolayfilt(x,N,l_lfilter);

