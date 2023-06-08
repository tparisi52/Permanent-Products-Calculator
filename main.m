% Run this script (type "main" into the command window) after specifying
% the options below. These options are the only things that need to be
% modified. The results can be seen in the 'formattedResultTable'
% and 'formattedPosetAdjMatrix' variables. The ouput is also written into
% an excel (.xlsx) file.


% ----------------------------------------------------------------------
% OPTIONS:

% Matrix size: Enter an integer >= 2.
% Program will take a very long time to run or could crash for large N (10 or higher)
N = 5; 


% Operation: Type one of the options exactly as spelled in the list,
%            including the double quotes.
% ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~
% OPERATION_LIST = ["permanent", "determinant"];
OPERATION = "permanent";


% Partition mode: Type one of the options exactly as spelled in the list,
%                 including the double quotes.
% ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~
% PARTITION_MODE_OPTIONS = ["default", "set_amount_limit", "set_size_limit"];
% - default: Uses I|I^c; yields 2^(N-1) poset elements
% - set_amount_limit: Partitions I_1, I_2, ..., I_k disjoint subsets of 
%                     {1,2,...,N}, less than or equal to a specified k
% - set_size_limit: Partitions into any amount of subsets, but limited by
%                   a maximum size for the subsets
PARTITION_MODE = "default";


% Partition mode limit (IGNORE THIS IF USING "default"): 
% Set PARTITION_LIMIT to an integer between 1 and N
% Used as the max set amount or max set size (see partition mode options)
PARTITION_LIMIT = 2;

% END OF OPTIONS
% ----------------------------------------------------------------------


% Computations are below (do not need to edit this for regular use)


% Setup by computing the lists of matrices and partitions
disp("Calculating partitions and matrices...")

unitIntervalMatrices = compute_unit_interval_matrices(N);
partitionList = compute_partition_list(N, PARTITION_MODE, PARTITION_LIMIT);
nMatrices = size(unitIntervalMatrices,1);
nPartitions = size(partitionList,1);


% Calculate the results
disp("Calculating " + OPERATION + "s...")

resultTable = cell(nMatrices, nPartitions);
if strcmpi(OPERATION, "permanent") % using permanents
    for i = 1:nMatrices
        current_matrix = unitIntervalMatrices{i,1};
        for j = 1:nPartitions
            resultTable{i,j} = submatrix_permanents(current_matrix, partitionList{j});
        end
    end
elseif strcmpi(OPERATION, "determinant") % or using determinants
    for i = 1:nMatrices
        current_matrix = unitIntervalMatrices{i,1};
        for j = 1:nPartitions
            resultTable{i,j} = submatrix_determinants(current_matrix, partitionList{j});
        end
    end
end


% Reformat the partition names into strings
disp("Formatting partition names...")

partitionNameList = cell(nPartitions,1);
for i = 1:nPartitions
    currPartition = partitionList{i,1};
    currName = "";
    for j=1:size(currPartition, 2)
        currName = currName + "[" + join(string(currPartition{1,j}),",") + "]";
    end
    partitionNameList{i,1} = currName;
end


% Compute poset adjacency matrix and degree lists
disp("Calculating adjacency matrix...")

posetAdjMatrix = cell(nPartitions, nPartitions);

posetInDegrees = cell(1, nPartitions);
posetInDegrees(1,:) = {0};
posetOutDegrees = cell(nPartitions, 1);
posetOutDegrees(:,1) = {0};

for i = 1:nPartitions
    for j = 1:nPartitions
        posetAdjMatrix{i,j} = 1;
        for k = 1:nMatrices
            if resultTable{k,i} > resultTable{k,j}
                posetAdjMatrix{i,j} = 0;
                break
            end
        end
        if posetAdjMatrix{i,j} == 1
            posetInDegrees{1, j} = posetInDegrees{1, j} + 1;
            posetOutDegrees{i, 1} = posetOutDegrees{i, 1} + 1;
        end
    end
end


% Reformat the tables of calculation results and the poset adjacency-matrix
disp("Formatting results...")


% results
formattedResultTable = cell(nMatrices+1, nPartitions+1);
formattedResultTable(2:nMatrices+1, 2:nPartitions+1) = resultTable;
formattedResultTable{1,1} = "N=" + N;

% adjacency matrix data
formattedPosetAdjMatrix = cell(nPartitions+2, nPartitions+2);
formattedPosetAdjMatrix(2:nPartitions+1, 2:nPartitions+1) = posetAdjMatrix;
formattedPosetAdjMatrix{1,1} = "N=" + N + " poset";

% in and out degrees
formattedPosetAdjMatrix{nPartitions+2,1} = "In Degree";
formattedPosetAdjMatrix(nPartitions+2, 2:nPartitions+1) = posetInDegrees;
formattedPosetAdjMatrix{1,nPartitions+2} = "Out Degree";
formattedPosetAdjMatrix(2:nPartitions+1, nPartitions+2) = posetOutDegrees;

% column labels for result table, row/col labels for adjacency matrix
for i = 1:nPartitions
    formattedResultTable{1, i+1} = partitionNameList{i};
    formattedPosetAdjMatrix{1, i+1} = partitionNameList{i};
    formattedPosetAdjMatrix{i+1, 1} = partitionNameList{i};
end
% row labels for result table
for i = 1:nMatrices
    formattedResultTable{i+1,1} = unitIntervalMatrices{i,2};
end


% export data to xlsx file
disp("Exporting data...")
export_data(N, OPERATION, PARTITION_MODE, PARTITION_LIMIT, ...
    formattedResultTable, formattedPosetAdjMatrix);

disp("Program done!")

