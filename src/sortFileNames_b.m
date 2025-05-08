%Andrew Burt - a.burt@ucl.ac.uk

function [directory,names,uniquenames] = sortFileNames_b(single_string_path)
	files = dir(single_string_path);
	[token,remain] = strtok(fliplr(single_string_path),'/');
	directory = fliplr(remain);
	fnames = {};
	for i = 1:length(files)
		fnames(i) = {[directory files(i).name]};
	end
	names = {};
    x = 0;
    y = 0;
	for j = 1:length(fnames)
	    tmp1 = strsplit(char(fnames(j)),'/');
        if length(char(tmp1)) > 13
            x = x + 1;
            tmp2 = strsplit(char(tmp1(length(tmp1))),'-');
	    	tmp3 = [sprintf('%s-',tmp2{1:end-2}),tmp2{end-1}];
            names(x) = {(tmp3)};
        else
            y = y + 1;
        end
	end
    names = names(1:end-y);
	uniquenames = unique(names);
end
