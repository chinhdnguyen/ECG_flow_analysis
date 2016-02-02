function ratio = countRR_eachBreath(R_index,breath_index)

Rnum = NaN(1,length(breath_index)-1);
for i=1:length(breath_index)-1
    temp = R_index(R_index>=breath_index(i) & R_index<=breath_index(i+1));
    Rnum(i) = length(temp);
end

% find the most frequent synchronization ratio
ratio = mode(Rnum,2);
