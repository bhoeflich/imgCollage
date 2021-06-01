classdef picCollage
    
    
    properties
        imgLst
    end
    
    methods
        function obj = picCollage(dirName)
            obj.imgLst = listDirs(dirName);
          
        end
        
        function directories = listDirs(dirName)
            %directories is list of strings, each string is a directorie of pic
            
            %Tasks for Method:
                %check if directory is missing 
                %must work for win and mac
                %maybe 2 methods of different method 
                %works only if folder with pics in same dir !!
                
            tempStr = dir(dirName);
            directories = {tempStr.name};
            
            %to delete . and .. (current and parent folder)
            directories(1) = [];
            directories(1) = [];
            
            % concatenates folder with / ans filname (Mac???)
        
            directories = strcat(dirName, '/', directories);
        end

    end
    
        
  
end

