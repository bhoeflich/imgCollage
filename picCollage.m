classdef picCollage
   
    properties
        imgDirPath
        imgLst
        
    end
    
    methods
        
        function obj = picCollage()
            %constructor
            
            % Dateipfad des Verzeichnisses mit den Bildern wird übergeben 
            obj.imgDirPath = cDirec('Choose a directory with images: \n');
            
            %Dateipfad wird listDird Funktion übergeben, um eine Liste von
            %Bilddateipfaden zu erstellen 
            obj.imgLst = listDirs(obj.imgDirPath);
        end
        
        function imgContainer = loadImgs(obj, n)
            %Läd die Bilder n Bilder in ein Cell array 
            imgContainer = cell(1, n);
            for i = 1:n
                imgContainer{i} = imread(char(obj.imgLst(i))); 
            %To Do:
                %Was passiert wenn n größer als Anzahl der Objekte in obj.imgLst!!!!!!!
                %if Abfrage 
            end
        end
        
            
            
        
        
            
    end
      
end
% dürfen wir montage verwenden oder sollen wir alles selber schreiben
% n rechtecke größer als anzahl bilder, ein leeres rechteck 
% wie ist der ansatz dafür 