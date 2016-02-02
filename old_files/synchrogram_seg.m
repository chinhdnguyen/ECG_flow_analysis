function [sync_phase,R_index]=synchrogram_seg(ecg,flow,ind,fs,m)
% This function read ecg and flow signals and generate its synchrogram

% Written by: Chinh Nguyen, PhD

% % Read ECG and flow signal
% ecg = ECG.values;
% fs_ecg = 1/ECG.interval;
% resp = Flow.values;
% fs_resp = 1/Flow.interval;
% t = (0:length(ecg)-1)/fs_ecg;
%
% % upsample flow signal to ecg fs
% if fs_resp<fs_ecg
%     resp = resample(resp,fs_ecg,fs_resp);
% end

% low pass filter flow signal
lf = 2;
flow = normalize(flow);
flow = zerophase_lowpass(flow,lf,fs);

% Detect Rpeak using Gari Clifford script
% ecg = normalize(ecg');
% threshold = mean(ecg)+3*std(ecg)
threshold = 0.2;
testmode=0;
[hrv, R_t, R_amp, R_index]  = rpeakdetect(ecg,fs,threshold,testmode);

% Calculate instantaneous phase of flowiratory signal
flow_p = hilbert(flow);
cumm_phase = unwrap(angle(flow_p));

% generate the synchrogram
synchro = cumm_phase(R_index);
synchro_new = mod(synchro,2*pi*m)/(2*pi);

phase_plot = mod(cumm_phase,2*pi*m)/(2*pi);

% figure;
% h(1)=subplot(411);plot(t,ecg);ylabel('ECG signal (n.u)');grid on;
% h(2)=subplot(412);plot(t,flow);ylabel('Flow signal (n.u)');grid on;
% h(3)=subplot(413);plot(t,phase_plot);grid on;
% hold on;plot(t(R_index),phase_plot(R_index),'.r','MarkerSize',14);
% ylabel('Instantaneous phase of flow signal');
% h(4)=subplot(414);plot(t(R_index),synchro_new,'.','MarkerSize',14);grid on;
% xlabel('Time (s)');ylabel(['Synchrogram with m = ',num2str(m)]);
% linkaxes(h,'x');

sync_phase = phase_plot(R_index);
R_index = ind(R_index);
%
% % %%%%%%%%%%%% CRQA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %      maxnorm     - Maximum norm.
% % %      euclidean   - Euclidean norm.
% % %      minnorm     - Minimum norm.
% % %      nrmnorm     - Euclidean norm between normalized vectors
% % %                    (all vectors have the length one).
% % %      maxnorm     - Maximum norm, fixed recurrence rate.
% % %      fan         - Fixed amount of nearest neighbours.
% % %      inter       - Interdependent neighbours.
% % %      omatrix     - Order matrix.
% % %      opattern    - Order patterns recurrence plot.
% %
% % switch pat_name
% %     case 1
% %         pattern = 'maxnorm';
% %     case 2
% %         pattern = 'euclidean';
% %     case 3
% %         pattern = 'minnorm';
% %     case 4
% %         pattern = 'nrmnorm';
% %     case 5
% %         pattern = 'maxnorm';
% %     case 6
% %         pattern = 'fan';
% %     case 7
% %         pattern = 'inter';
% %     case 8
% %         pattern = 'omatrix';
% %     case 9
% %         pattern = 'opattern';
% % end
% %
% dim = 2;
% delay = 1;
% neighbor = 0.3;
% win_length = length(sync_phase);
% step_length = 1;
% LMIN = 2;
% VMIN = 2;
% TW = 1;
% pattern = 'euc';
% try
%     y=crqa(synchro_new,dim,delay,neighbor,win_length,step_length,LMIN,VMIN,TW,pattern,'silent');
%     L = y(:,3);
%     %     Lnorm = 2*L/(win_length-2);
%     %     Lnorm = y(:,4);
%     Lnorm = L;
% catch
%     Lnorm = 0;
% end
