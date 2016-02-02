function [hdr, record] = readedf_crs(study)

% select folder
folder = uigetdir('Select folder');
cd(folder);

% list all EDF or REC files
% s = dir('*.edf');
s = [dir('*.edf'); dir('*.REC')];

% loop thru all the files
for i = 1:length(s)
    try
        filename = s(i,1).name
        
        % initiate channel names
        if study==1 % study = 1 with Pleth and higher fs
            channame = {'Flow','Pleth','rescFlow','rescontr','Thermist','FlowPat','THOR','ABDO','ECG1','ECG2','SpO2'};
        else
            channame = {'NASALFLOW','THEMISTER','CHEST','ABDOMEN','ECG1ECG2','SaO2'};
        end
        
        % Read EDF or REC file
        [hdr, record] = edfread(filename,'targetsignals',channame);
        
        % read channel number, and sampling freq, exclude Flow thermistor
        for i=1:length(hdr.samples)
            % Grab sampling frequency
            fs(i) = hdr.samples(i);
        end
        % get filename without extension
        [~,name,~] = fileparts(filename);
        
        data = record;
        
        % save result
        result.edffile = filename;
        %         result.ep30s = (1:length(ss))';
        result.fs = fs;
        
        % save to structure
        if study==1
            try
                result.Flow = data(5,1:end*fs(5)/fs(1));
                result.Pleth = data(4,1:end*fs(4)/fs(1));
                result.rescFlow = data(6,1:end*fs(6)/fs(1));
                result.Thermist = data(7,1:end*fs(7)/fs(1));
                result.Thor = data(8,1:end*fs(8)/fs(1));
                result.Abdo = data(9,1:end*fs(9)/fs(1));
                result.ECG1 = data(1,:);
                result.ECG2 = data(2,:);
                result.SpO2 = data(3,1:end*fs(3)/fs(1));
            catch
                result.Flow = data(5,1:end*fs(5)/fs(1));
                result.Pleth = data(4,1:end*fs(4)/fs(1));
                result.rescFlow = data(6,1:end*fs(6)/fs(1));
                result.Thermist = [];
                result.Thor = data(7,1:end*fs(7)/fs(1));
                result.Abdo = data(8,1:end*fs(8)/fs(1));
                result.ECG1 = data(1,:);
                result.ECG2 = data(2,:);
                result.SpO2 = data(3,1:end*fs(3)/fs(1));
            end
            
        else
            result.fs = result.fs./10;
            result.Flow = data(1,1:end*fs(1)/fs(1));
            result.Pleth = [];
            result.rescFlow = [];
            result.Thermist = data(2,1:end*fs(2)/fs(1));
            result.Thor = data(3,1:end*fs(3)/fs(1));
            result.Abdo = data(4,1:end*fs(4)/fs(1));
            result.ECG1 = data(5,1:end*fs(5)/fs(1));
            result.ECG2 = [];
            result.SpO2 = data(6,1:end*fs(6)/fs(1));
        end
        % save as matfile
        save([name,'.mat'], '-struct', 'result');
    catch
    end
end
