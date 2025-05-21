function [] = runopt(SINGLE_PATH_TO_MODELS)
    startTime = datetime('now');
    disp(['[', datestr(startTime, 'yyyy-mm-dd HH:MM:SS'), '] Processing started.']);
    tic;

    [uniquedirs, uniquenames] = sortFileNames(SINGLE_PATH_TO_MODELS);

    for i = 1:length(uniquenames)
        qsm = struct('cylinder', {}, 'branch', {}, 'treedata', {}, 'rundata', {}, 'pmdistance', {}, 'triangulation', {});

        pattern = fullfile(uniquedirs{i}, [uniquenames{i}, '-*.mat']);
        filestruct = dir(pattern);
        modelnames = fullfile({filestruct.folder}, {filestruct.name});

        disp(['Searching directory: ', uniquedirs{i}]);
        disp(['Found ', num2str(length(modelnames)), ' candidate .mat files matching pattern ''', uniquenames{i}, '-*.mat''.']);
        disp(['Number of QSMs successfully loaded for ', uniquenames{i}, ': ', num2str(length(modelnames))]);

        for j = 1:length(modelnames)
            try
                model = load(modelnames{j});
                qsm(j) = model.qsm;
            catch
                warning('Failed to load or assign model: %s', modelnames{j});
            end
        end

        valid = true;
        for k = 1:length(qsm)
            if isempty(qsm(k).cylinder)
                valid = false;
                break
            end
        end

        % Construct the output filename only (no path)
        opt_qsm_filename = [char(uniquenames(i)), '_opt.mat'];

        if valid
            try
                select_optimum_mod(qsm, [char(uniquenames(i)), '_opt']);
                disp(['Generated opt QSM file: ', opt_qsm_filename]);
            catch ME
                warning(['Error in select_optimum_mod: ', ME.message])
            end
        else
            warning(['No valid QSMs for ', char(uniquenames(i))])
        end

        %% Fallback (also prints file name)
        %try
        %    select_optimum_mod(qsm, [uniquenames{i}, '_opt']);
        %    disp(['Generated opt QSM file: ', opt_qsm_filename]);
        %catch
        %    warning('Failed to run select_optimum_mod on: %s', uniquenames{i});
        %end
    end

    elapsedTime = toc;
    finishTime = datetime('now');
    disp(['[', datestr(finishTime, 'yyyy-mm-dd HH:MM:SS'), '] Processing finished.']);
    disp(['Total processing time: ', num2str(elapsedTime, '%.2f'), ' seconds (', num2str(elapsedTime/60, '%.2f'), ' minutes).']);
end