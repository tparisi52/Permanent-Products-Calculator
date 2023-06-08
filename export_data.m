% writes resultTable and posetAdjMatrix data to an excel file, naming the
% file based on the input options
function export_data(N, operation, mode, limit, resultTable, posetAdjMatrix)
    % construct file name
    filename = "N=" + N + " " + operation;
    if strcmpi(mode, "set_amount_limit") || strcmpi(mode, "set_size_limit")
        filename = filename + " " + mode + "=" + limit;
    end
    % add other partition mode naming systems using elseif here

    filename = filename + ".xlsx";

    % write data to excel
    writecell(resultTable, filename, 'Sheet', 'Results', 'Range', 'A1');
    writecell(posetAdjMatrix, filename, 'Sheet', 'Poset', 'Range', 'A1');
end