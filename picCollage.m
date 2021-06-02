classdef picCollage
   
    properties
        imgPath
        imgLst
        
    end
    
    methods
        function obj = picCollage()
            obj.imgPath = cDirec('Choose a directory with images: \n');
            obj.imgLst = listDirs(obj.imgPath);
        end
 
    end
      
end

