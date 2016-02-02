function [lambda,Lnorm] = CRS_analysis(R_index,cumm_phase,ratio)

% generate the synchrogram
m=1;
synchro = cumm_phase(R_index);
synchro_new = mod(synchro,2*pi*m)/(2*pi);

%% conventional CRS lambda
lambda = crs_lambda(synchro_new,ratio);

%% CRS recurrence plot analysis
dim = 2;
delay = 1;
neighbor = 0.3;
win_length = length(synchro_new);
step_length = 1;
LMIN = 2;
VMIN = 2;
TW = 1;
pattern = 'euc';

try
    y=crqa(synchro_new',dim,delay,neighbor,win_length,step_length,LMIN,VMIN,TW,pattern,'silent');
    L = y(:,3);
    Lnorm = 2*L/(win_length-2);
catch
    Lnorm = 0;
end
