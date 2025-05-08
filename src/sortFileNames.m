%Andrew Burt - a.burt@ucl.ac.uk

function [uniquedirs, uniquenames] = sortFileNames(single_string_path)
    fileStruct = dir(single_string_path);
    files = fullfile({fileStruct.folder}, {fileStruct.name});
    names = {};
    dirs = {};
    for j = 1:length(files)
        [dirPath, name, ext]  = fileparts(files{j});
        tmp = strsplit(name, '-');
        names{j} = tmp{1};
        dirs{j} = dirPath;
    end
    uniquenames = unique(names);
    uniquedirs = unique(dirs);
end