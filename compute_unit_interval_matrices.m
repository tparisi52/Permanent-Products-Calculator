% Computes a list of all unit-interval matrices of size N
function unitIntervalMatrices = compute_unit_interval_matrices(N)
    % Check for valid input
    if (nargin ~= 1) || (N ~= floor(N)) || (N < 1)
        error('N must be a positive integer')
    end

    % Generate all C_n unit interval matrices of size N
    catalanN = nchoosek(2*N, N) / (N+1);
    unitIntervalMatrices = cell(catalanN, 2);
    % First column is NxN matrix, 2nd column is human-readable matrix name.
    % Matrices are named with a list of the number of 0's in the 1st, 2nd, ..., (N-1)th row.

    zeroList = zeros(N-1, 1);

    % add the matrix of all ones to unitIntervalMatrices
    unitIntervalMatrices{1, 1} = ones(N);
    unitIntervalMatrices{1, 2} = "[" + join(string(zeroList), ",") + "]";

    % add matrices that have zero's to unitIntervalMatrices
    counter = 2;
    currRow = 1;
    while counter <= catalanN   
        % add another 0 to the list in the current row
        zeroList(currRow) = zeroList(currRow) + 1;
        currRow = currRow + 1;
        
        % create matrix and store in unitIntervalMatrices
        unitIntervalMatrices{counter, 1} = make_matrix_from_zeros(N, zeroList);
        unitIntervalMatrices{counter, 2} = "[" + join(string(zeroList), ",") + "]";
        %zeroList;

        % update the 0-list if the last row is reached
        if currRow == N
            currRow = currRow - 1;
            while 1 %loop forever
                if currRow == 1 
                    %reset to increment from row 1
                    break
                end
                if zeroList(currRow) < N - currRow && zeroList(currRow) < zeroList(currRow-1)
                    %reset to increment from current row
                    break
                end
                zeroList(currRow) = 0;
                currRow = currRow - 1;
            end
        end

        counter = counter + 1;
    end
end

% helper function that returns a single unit-interval matrix given N and
% the number of zeros in each row (Nth row is all 1's is implied).
function matrix = make_matrix_from_zeros(N, zero_list)
    matrix = ones(N);
    for row = 1:(N-1)
        left_zero_pos = N + 1 - zero_list(row);
        if zero_list(row) > 0
            matrix(row, left_zero_pos:N) = 0;
        end
    end
end