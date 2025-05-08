function [] = runopt(SINGLE_PATH_TO_MODELS)
    [uniquedirs, uniquenames] = sortFileNames(SINGLE_PATH_TO_MODELS);

    for i = 1:length(uniquenames)
        qsm = struct('cylinder', {}, 'branch', {}, 'treedata', {}, 'rundata', {}, 'pmdistance', {}, 'triangulation', {});
        
        % Build the pattern as a char array (MATLAB requires it)
        pattern = fullfile(uniquedirs{i}, [uniquenames{i}, '-*.mat']);
        filestruct = dir(pattern);
        modelnames = fullfile({filestruct.folder}, {filestruct.name});

        for j = 1:length(modelnames)
            try
                model = load(modelnames{j});
                qsm(j) = model.qsm;
            catch
                warning('Failed to load or assign model: %s', modelnames{j});
            end
        end
		
		% debug
		disp(['Number of QSMs loaded for ', char(uniquenames(i)), ': ', num2str(length(qsm))])
		valid = true;
		for k = 1:length(qsm)
			if isempty(qsm(k).cylinder)
				valid = false;
				break
			end
		end
		if valid
			try
				select_optimum_mod(qsm, char(uniquenames(i)));
			catch ME
				warning(['Error in select_optimum_mod: ', ME.message])
			end
		else
			warning(['No valid QSMs for ', char(uniquenames(i))])
		end
        % end of debug
		
		try
            select_optimum_mod(qsm, uniquenames{i});
        catch
            warning('Failed to run select_optimum_mod on: %s', uniquenames{i});
        end
    end
end