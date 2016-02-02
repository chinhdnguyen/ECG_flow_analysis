function result = save2csv(index,hr,rr,crs,file)

result = catstruct(index,hr,rr,crs);

[~,name,~] = fileparts(file); 

struct2csv(result,[name,'_result.csv']);