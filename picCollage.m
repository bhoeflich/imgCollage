classdef picCollage
    
    properties
        imgPath
        imgLst
        
    end
    
    methods
        function obj = picCollage()
            obj.imgPath = uigetdir;
            obj.imgLst = listDirs(obj.imgPath);
        end
        
        function directories = listDirs(dirName)
            %directories is a cell of strings, each string is a directory of pic
            tempStruct = dir(dirName);
            %fullfile concatenates folder and file to path for win or mac
            directories = fullfile({tempStruct(3:length(tempStruct)).folder}, {tempStruct(3:length(tempStruct)).name});
        end
        

    end
    
        
  
end

