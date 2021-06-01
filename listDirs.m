function directories = listDirs(dirName)
%directories is list of strings, each string is a directorie of pic


tempStr = dir(dirName);
directories = {tempStr.name};

%to delete . and .. (current and parent folder)
directories(1) = [];
directories(1) = [];
%cell beschränken und code verkürzen 

directories = fullfile(dirName, directories);
end

