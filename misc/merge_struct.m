function C = merge_struct(A,B)

names = fieldnames(A);
for i = 1:length(names)
%     C.(names{i}) = cat(A.(names{i}),B.(names{i}),1);
      C.(names{i}) = ([(A.(names{i}))',(B.(names{i}))'])';
end