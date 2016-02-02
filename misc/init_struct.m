function B = init_struct(A,B)

names = fieldnames(A);
for i = 1:length(names)
    B.(names{i}) = [];
end
