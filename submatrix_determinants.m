% Computes the product of minors for a given matrix and partition
function d = submatrix_determinants(A, I)
    % I is a cell array containing the sets making up the partition.
    d = 1;
    nSets = size(I,2); % number of sets in I
    for k = 1:nSets
        currSet = I{k};
        d = d * det(A(currSet, currSet));
    end
end