classdef picCollage
    
    
    properties
        picStru
        picLst
    end
    
    methods
        function obj = picCollage(dirName)
            obj.picStru = dir(dirName);
            obj.picLst = fileLst(obj.picStru);
        end
        
        function lst = fileLst(files)
            for i = 1:length(files)
                if files(i).name ~= '.' || struct(i).name ~= '..'
                    lst(end+1) = files(i).name;
                end
                
            end
        end
        
    end
end

