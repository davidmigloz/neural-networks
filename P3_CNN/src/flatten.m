function [ B ] = flatten(A)
    B = reshape(A, [1, numel(A)]);
end