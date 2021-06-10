function [maxImgHeight, maxImgWidth] = maxSize(Container)
imgHeight = [];
imgWidth = [];

for i = 1:length(Container)
    [imgHeight(i), imgWidth(i), clrs(i)] = size(Container{i});
end

maxImgHeight = max(imgHeight);
maxImgWidth = max(imgWidth);
end

