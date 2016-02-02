function [sync_phase_whole,R_index_whole]=synchrogram_wholetrace(winL,m,plotflag)
warning off;

[file,path] = uigetfile('Select mat-file to analyse');
cd(path);

% load signal
ECG = load(file,'ECG1');
ECG = ECG.ECG1;

Flow = load(file,'Thor');
Flow = Flow.Thor;

Flow1 = load(file,'Abdo');
Flow1 = Flow1.Abdo;

Flow2 = load(file,'rescFlow');
Flow2 = Flow2.rescFlow;
if isempty(Flow2)
    Flow2 = load(file,'Flow');
    Flow2 = Flow2.Flow;
end

maxL=max([length(ECG),length(Flow),length(Flow1),length(Flow2)]);

% resample
ECG = resample(ECG,round(maxL/length(ECG)),1);
Flow = resample(Flow,round(maxL/length(Flow)),1);
Flow1 = resample(Flow1,round(maxL/length(Flow1)),1);
Flow2 = resample(Flow2,round(maxL/length(Flow2)),1);

fs = load(file,'fs');fs = fs.fs;
fs = max(fs);

%winL in minute
winL = winL*60*fs;
% filterflag = 0;
% plotflag = 1;

ind = 1:maxL;
t = ind/fs;
tepoch = (1:30*fs:maxL)/fs;

ECGseg = buffer(ECG,winL,0);
Flowseg = buffer(Flow,winL,0);
Flowseg1 = buffer(Flow1,winL,0);
Flowseg2 = buffer(Flow2,winL,0);

indseg = buffer(ind,winL,0);

[r,c] = size(ECGseg);

sync_phase_whole = [];
R_index_whole = [];
sync_phase_whole1 = [];
R_index_whole1 = [];
R_index_whole2 = [];
sync_phase_whole2 = [];
for i = 1:c
    [sync_phase,R_index]=synchrogram_seg(ECGseg(:,i),Flowseg(:,i),indseg(:,i),fs,m);
    sync_phase_whole = cat(1,sync_phase_whole, sync_phase);
    R_index_whole = cat(1,R_index_whole, R_index);
    
%     [sync_phase1,R_index1]=synchrogram_seg(ECGseg(:,i),Flowseg1(:,i),indseg(:,i),fs,m);
%     sync_phase_whole1 = cat(1,sync_phase_whole1, sync_phase1);
%     R_index_whole1 = cat(1,R_index_whole1, R_index1);
%     
%     [sync_phase2,R_index2]=synchrogram_seg(ECGseg(:,i),Flowseg2(:,i),indseg(:,i),fs,m);
%     sync_phase_whole2 = cat(1,sync_phase_whole2, sync_phase2);
%     R_index_whole2 = cat(1,R_index_whole2, R_index2);
end
% %
% dim = 2;
% delay = 1;
% neighbor = 0.3;
% win_length = 60;
% step_length = 1;
% LMIN = 2;
% VMIN = 2;
% TW = 1;
% pattern = 'euc';
% try
%     y=crqa(sync_phase_whole,dim,delay,neighbor,win_length,step_length,LMIN,VMIN,TW,pattern,'silent');
%     L = y(:,3);
%     %     Lnorm = 2*L/(win_length-2);
%     %     Lnorm = y(:,4);
%     Lnorm = L;
% catch
%     Lnorm = 0;
% end
if plotflag
    figure;
    h(1)=subplot(411);plot(t,ECG);grid on;ylabel('ECG');
    h(2)=subplot(412);plot(t,Flow);grid on;ylabel('Flow');
    h(3)=subplot(413);plot(t(R_index_whole),sync_phase_whole,'.','MarkerSize',12);grid on;ylabel('From Thor');
% %     h(4)=subplot(514);plot(t(R_index_whole1),sync_phase_whole1,'.','MarkerSize',12);grid on;ylabel('From Abdo');
% %     h(5)=subplot(515);plot(t(R_index_whole2),sync_phase_whole2,'.','MarkerSize',12);grid on;ylabel('From rescFlow');
% %     h(4)=subplot(414);plot(tepoch,Lnorm,'-');grid on;ylabel('Synchronization degree');
%     h(4)=subplot(414);plot(t(R_index_whole(1:length(Lnorm))),Lnorm,'-');grid on;ylabel('Synchronization degree');

    xlabel('Time (s)');
    linkaxes(h,'x');
end
% plot(sync_phase_whole,'.','MarkerSize',12);grid on;