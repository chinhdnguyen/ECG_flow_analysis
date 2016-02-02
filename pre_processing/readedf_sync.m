function [hdr, record] = readedf_sync()
% function [hdr,data,sstage_n,time,fs] = readedf_morph()

% load edf file
folder = uigetdir('Select folder');
cd(folder);

s = dir('*.edf');

for i = 1:length(s)
    try
        filename = s(i,1).name
        
        % initiate channel names
        channame = {'ECG1-ECG2','TERMISTORE','TORACE','ADDOME'};
                channame = {'ECG1-ECG2','TERMISTORE','TORACE','ADDOME'};

        % read edf for Flow, THO and ABD
        [hdr, record] = edfread(filename,'targetsignals',channame);
        
        % read channel number, and sampling freq, exclude Flow thermistor
        for i=1:length(channame)
            % Grab sampling frequency
            fs(i) = hdr.samples(i);
        end
        % get filename without extension
        [~,name,~] = fileparts(filename);
        
        % load sleep stage
        ss = readss([name,'.txt']);
        % assign values of each channels
        % L = length(ss)*30*fs(1);
        % data = record(:,1:L);
        data = -record;
        
        % save result
        result.edffile = filename;
        result.ep30s = (1:length(ss))';
        result.fs = fs;
        result.ECG = data(1,:);
        result.Flow = data(2,1:end*fs(2)/fs(1));
%         result.Tho = data(3,1:end*fs(3)/fs(1));
%         result.Abd = data(4,1:end*fs(4)/fs(1));
        result.sstage = ss;
        result.time = (1:length(result.ECG))/fs(1);
        result.ssfile = [name,'.txt'];
        
        % save as matfile
        save([name,'.mat'], '-struct', 'result');
    catch
    end
end
% % code sleep stage, generate hypnogram
% [sstage_n,time] = gen_hypnogram(ss,fs,caseselect);
%
% % plot, will be very slow due to high sampling rate
% if plotflag
%     figure;
%     stem(time/fs(1),sstage_n);
%
%     t = (1:length(data(1,1:L)))/fs;
%     figure;
%     h(1)=subplot(411);stem(time/fs,sstage_n);
%     h(2)=subplot(412);plot(t,data(1,:));grid on;ylabel(channame{1});
%     h(3)=subplot(413);plot(t,data(2,:));grid on;ylabel(channame{2});
%     h(4)=subplot(414);plot(t,data(3,:));grid on;ylabel(channame{3});
%     linkaxes(h,'x');xlabel('Time (s)');
% end