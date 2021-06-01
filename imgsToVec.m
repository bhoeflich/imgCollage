function lst = imgsToVec(directories)
%directory must be list of list of img directories in ''
for i = 1:length(directories)
    lst(end+1) = imread(directories{i});
end

