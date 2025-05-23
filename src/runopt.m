function [] = runopt(file_arg)
    startTime = datetime('now');
    disp(['[', datestr(startTime, 'yyyy-mm-dd HH:MM:SS'), '] Processing started.']);
    tic;

    % If the input is a string, check for wildcard
    if ischar(file_arg) || (isstring(file_arg) && isscalar(file_arg))
        filestruct = dir(file_arg);
        mat_file_list = fullfile({filestruct.folder}, {filestruct.name});
    elseif iscell(file_arg)
        mat_file_list = file_arg;
    else
        error('Input must be a filename pattern string or a cell array of file names.');
    end

    if isempty(mat_file_list)
        error('No .mat files found for the given input.');
    end

    disp(['Searching directory: ', fileparts(mat_file_list{1})]);
    disp(['Number of candidate .mat files: ', num2str(length(mat_file_list))]);

    qsm = struct('cylinder', {}, 'branch', {}, 'treedata', {}, 'rundata', {}, 'pmdistance', {}, 'triangulation', {});
    for j = 1:length(mat_file_list)
        try
            model = load(mat_file_list{j});
            qsm(j) = model.qsm;
        catch
            warning(['Failed to load or assign model: ', mat_file_list{j}]);
        end
    end

    disp(['Number of QSMs successfully loaded: ', num2str(length(qsm))]);

    % Validate QSMs
    valid = true;
    for k = 1:length(qsm)
        if isempty(qsm(k).cylinder)
            valid = false;
            break
        end
    end

    if valid
        try
            [TreeData,OptModels,OptInputs, outputFilename] = select_optimum_mod(qsm);
            disp(['Generated opt QSM file: ', outputFilename]);
        catch ME
            warning(['Error in select_optimum_mod: ', ME.message])
        end
    else
        warning('No valid QSMs found in this set.');
    end

    elapsedTime = toc;
    finishTime = datetime('now');
    disp(['[', datestr(finishTime, 'yyyy-mm-dd HH:MM:SS'), '] Processing finished.']);
    disp(['Total processing time: ', num2str(elapsedTime, '%.2f'), ' seconds (', num2str(elapsedTime/60, '%.2f'), ' minutes).']);
    disp('----------------------------------------');
    disp(' ');
end