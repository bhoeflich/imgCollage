function vector = imgsToVec(directories, dirName)
%directory must be list of list of img directories in ''
for i = 1:length(directory)
    vector(end+1) = imread(directories(i));
end

