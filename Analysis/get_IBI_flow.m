function [IBI,cumm_phase,breath_index] = get_IBI_flow(flow,fs)
% calculate IBI from flow signal using Hilbert transform

% find instantaneous phase of flow
flow_p = hilbert(flow);
cumm_phase = unwrap(angle(flow_p));
phase_cycle = mod(cumm_phase,2*pi)/(2*pi);

% detect phase cycle 
threshold = 0.8;
temp = peakdet(phase_cycle,threshold);
breath_index = temp;
IBI = diff(temp(:,1))./fs;

% figure;
% h(1)=subplot(211);plot(flow);
% h(2)=subplot(212);plot(phase_cycle);
% hold on;
% plot(IBI,phase_cycle(IBI),'*r');
% linkaxes(h,'x');