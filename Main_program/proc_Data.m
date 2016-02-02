function [Index,HRV_result,IBI_result,CRS_result] = proc_Data(ECGseg,Flowseg,indseg,fs)

% c: number of segments
[~,c] = size(ECGseg);

HRV_result = [];
IBI_result = [];
CRS_result = [];

m = 1;
for i = 1:c
    i
    try
        [HRV_seg,IBI_seg,CRS_seg] = proc_Seg(ECGseg(:,i),Flowseg(:,i),indseg(:,i),fs,m);
        % initialize HRV_result
        if i == 1
            HRV_result = init_struct(HRV_seg,HRV_result);
            IBI_result = init_struct(IBI_seg,IBI_result);
            CRS_result = init_struct(CRS_seg,CRS_result);
            
            HRV_init = HRV_result;
            IBI_init = IBI_result;
            CRS_init = CRS_result;
        end
    catch
        
        HRV_seg = error_struct(HRV_init,HRV_init);
        IBI_seg = error_struct(IBI_init,IBI_init);
        CRS_seg = error_struct(CRS_init,CRS_init);
        
    end
    
    HRV_result = merge_struct(HRV_result,HRV_seg);
    IBI_result = merge_struct(IBI_result,IBI_seg);
    CRS_result = merge_struct(CRS_result,CRS_seg);
    
end

Index.epoch_num = (1:c)';