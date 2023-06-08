% Computes the product of permanents of submatrices for a given matrix and partition
function p = submatrix_permanents(A, I)
    % I is a cell array containing the sets making up the partition.
    p = 1;
    nSets = size(I,2); % number of sets in I
    for k = 1:nSets
        currSet = I{k};
        p = p * permanent(A(currSet, currSet));
    end
end