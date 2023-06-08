% Computes a list of partitions given the size N, the mode with which to create
% partitions, and an optional third parameter to specify how to use the
% mode.

% More modes can be added to this code at either of the two specified
% locations marked ***

function partitionList = compute_partition_list(N, mode, limit)
    % mode(s) that do not use the limit parameter:

    % "default" MODE: creates partitions that use 2 subsets (and the trivial 1
    % subset partition)
    if strcmpi(mode, "default")
        partitionList = [partitions(N,2); partitions(N,1)];

    % ***To add new modes that do not need the limit parameter, add elseif
    % statements here.
    

    % modes that do use the limit parameter:
    else
        % check that limit is valid
        if (limit ~= floor(limit)) || (limit < 1)
            error('The parition limit parameter must be a positive integer')
        elseif limit > N
            error('The parition limit parameter must not exceed N')
        end
        
        % "set_amount_limit" MODE: partitions into 'limit' or fewer subsets
        if strcmpi(mode, "set_amount_limit")
            partitionList = {};
            for i = 1:limit
                partitionList = [partitionList; partitions(N,i)];
            end

        % "set_size_limit" MODE: partitions into subsets of at most size 'limit'
        elseif strcmpi(mode, "set_size_limit")
            % create list of all possible partitions, and copy over only
            % those that fit the limit
            partitionListOld = partitions(N);
            partitionList = {};
            nPartitions = size(partitionListOld);
            for i = 1:nPartitions
                currPartition = partitionListOld{i};
                currPartitionFitsLimit = 1; %1=true, 0=false
                for j = 1:size(currPartition, 2)
                    if size(currPartition{j}, 2) > limit
                        currPartitionFitsLimit = 0;
                        break;
                    end
                end
                if currPartitionFitsLimit
                    partitionList = [partitionList; {currPartition}];
                end
            end
         
        
        % ***To add new modes that use the limit parameter, add elseif
        % statements here.


        % Otherwise if an invalid mode is not given, raise an error
        else
            error("Invalid partition mode");
        end
    end