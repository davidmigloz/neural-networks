n = 10;

T = readtable('max_fail_filter.csv');
% Valor de confusión
for j=1:1:n
    max_fail = T{j, 4};
    c = T{j, 2};
    fprintf('(%d,%f)',max_fail,c);
end
fprintf('\n');