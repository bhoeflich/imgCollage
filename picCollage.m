classdef picCollage
    
    properties  
        imgDirPath
        imgLst
        imgContainer
        imgMaxSize
        img1Size
        pattCol
        n
        border
    end
    
    methods
            
        function obj = picCollage(n, border)
            %constructor
            
            % Dateipfad des Verzeichnisses mit den Bildern wird übergeben
            obj.imgDirPath = cDirec('Choose a directory with images: \n');
            
            %Dateipfad wird listDird Funktion übergeben, um eine Liste von
            %Bilddateipfaden zu erstellen
            obj.imgLst = listDirs(obj.imgDirPath);
            
            %Anzahl der Bilder aus dem Verzeichnis
            obj.n = n;
            
            %Rand um Bilder in px
            obj.border = border;
            
            %Container mit n Bildern aus dem Verzeichnis in einem cell
            %array
            obj.imgContainer = obj.loadImgs;
            
            %Maximale Fotodimension der Bilder im Container
            obj.imgMaxSize = obj.maxSize;
            
            %height and width of first pic in Container 
            obj.img1Size = size(obj.imgContainer{1});
            
            %Raster für uniform Collage
            obj.pattCol = obj.patternCol();
            
        end
        
        function collage = uniformCol(obj)
            %info:
                % creates collage with pictures of same size 
            %return
                %format: vector 1x2, info about height, width 
            %input args:
                %obj.pattCol obj.imgMaxSize obj.border
            %usage:
                %uniform collage
            collage = imgUniPlace(obj, buildFrame(obj.calcUniFrame()));
            
            image(collage)
            axis image
            axis off
            
        end
        
        function collage = noUniformCol(obj)
            collage = imgNoUniPlace(obj, buildFrame(obj.calcNoUniFrame()));
            
            image(collage)
            axis image
            axis off
        end
        
        
        function collage = imgUniPlace(obj, frame)
            
            [imgX, imgY] = obj.imgUniPosition();
            
            counter = 1;
            for row = 1:length(imgY)
                for col = 1:length(imgX)
                    if counter <= obj.n
                        frame(imgY{row}(1):imgY{row}(2), imgX{col}(1):imgX{col}(2),:) = imresize(obj.imgContainer{counter}, obj.imgMaxSize);
                        counter = counter +1;
                    end
                    
                end
            end
            collage = frame;
        end 
        
        function [imgX, imgY] = imgUniPosition(obj)
            %Platz fuer jedes Bild definieren (x,y) Abstand zu Achsen im Frame
            %Abstand ist aktuell Rand|Maximale Bildbreite|Rand|Maximale Bildbreite| ...
            %Bilder sind noch linksbündig
            
            %To Do:
            %Formel fuer mittige Platzierung anstatt von maxImgWidth
            
            for c = 1:obj.pattCol(2)
                imgX{c} = [(((obj.border + 1) + ((c-1) * (obj.border) + ((c-1) * (obj.imgMaxSize(2)))))), ((c * obj.border) + (c * (obj.imgMaxSize(2))))];
            end
            
            for r = 1:obj.pattCol(1)
                imgY{r} = [(((obj.border + 1) + ((r-1) * (obj.border) + ((r-1) * (obj.imgMaxSize(1)))))), ((r * obj.border) + (r * (obj.imgMaxSize(1))))];
            end
            imgY = transpose(imgY);
            
        end
        
        function Container = loadImgs(obj)
            %info:
                % loads images into cell array
            %return
                %format: cell array with uint8 in every cell 
            %input args:
                %obj.pattCol obj.imgMaxSize obj.border
            %usage:
                %uniform collage
            %laed die Bilder n Bilder in ein Cell array
            Container = cell(1, obj.n);
            for i = 1:obj.n
                Container{i} = imread(char(obj.imgLst(i)));
                %To Do:
                %Was passiert wenn n groesser als Anzahl der Objekte in obj.imgLst!!!!!!!
                %if Abfrage
            end
        end
        
        function maxImgDim = maxSize(obj)
            for i = 1:length(obj.imgContainer)
                [imgHeight(i), imgWidth(i), clrs(i)] = size(obj.imgContainer{i});
            end
            
            maxImgDim = [max(imgHeight), max(imgWidth)];
        end
        
        function pattCol = patternCol(obj)
            %info:
            % makes pattern for collage
            %return
            %format: vector 1x2, info about rows and collumns of
            %collage
            %input args:
            %obj.n
            %usage:
            %uniform collage
            
            %Legt die Reihen und Spalten der Collage fest
            %To Do
            %Spaltenanzahl nach n variabel machen
            colsCol = 3;
            if mod(obj.n , colsCol) == 0
                rowsCol = obj.n/colsCol;
            else
                rowsCol = ceil(obj.n/colsCol);
            end
            %Vektot mit Anzahl der Reihen und Spalten der Collage
            pattCol = [rowsCol, colsCol];
        end
        
        function frameDims = calcUniFrame(obj)
            %info:
            % calculates dimensions of the background frame for uniform
            % collage
            %return
            %format: vector 1x2, info about height, width
            %input args:
            %obj.pattCol obj.imgMaxSize obj.border
            %usage:
            %uniform collage
            height = (obj.pattCol(1) * obj.imgMaxSize(1)) + obj.border * (obj.pattCol(1) + 1);
            width = (obj.pattCol(2) * obj.imgMaxSize(2)) + obj.border * (obj.pattCol(2) + 1);
            frameDims = [height, width];
        end
        
        function frameDims = calcNoUniFrame(obj)
            %info:
            %calculates dimensions of the background frame for nonunif
                %collage
            %return
                %format: vector 1x2, info about height, width
            %input args:
                %obj.pattCol obj.imgMaxSize obj.border
            %usage:
                %uniform collage
            
            if obj.img1Size(1) >= obj.img1Size(2)
                
                %biggest picture upright
                height = 2 * obj.border + obj.img1Size(1);
                width = 2 * obj.border + 2 * obj.img1Size(2);
                
            else
                %biggest picture landscape
                height = 2 * obj.border + 2 * obj.img1Size(1);
                width = 2 * obj.border + obj.img1Size(2);
            end
            
            frameDims = [height, width];
        end
         
        function imgDims = patternNoUniCol(obj)
            
            
            % Dimensions of first picture are max. dimensions
            
            height(1)  = obj.img1Size(1);
            width(1) = obj.img1Size(2);
            
            % Depending on picture format, division starts at either height
            % or width
            % k array for dividing in one direction every second iteration
            % Dimensions divided are those of prior iteration
            
            if height(1) >= width(1)
                for i = 2:obj.n
                    k = (-1)^(i+1);
                    if k == -1
                        height(i) = floor(height(i-1)/2);
                        width(i) = floor(width(i-1));
                    else
                        height(i) = floor(height(i-1));
                        width(i) = floor(width(i-1)/2);
                    end
                    
                end
                
            else
                for i = 2:obj.n
                    k = (-1)^(i+1);
                    if k == 1
                        height(i) = floor(height(i-1)/2);
                        width(i) = floor(width(i-1));
                    else
                        height(i) = floor(height(i-1));
                        width(i) = floor(width(i-1)/2);
                    end
                end
                
            end
            imgDims = {height , width};
        end
                
        function [imgX, imgY] = imgNoUniPosition(obj, imgDims)
            %if Abfrage 
            
            %if obj.img1Size(1) >= obj.img1Size(2)
            %portait
            %***** ********** ********** **********
            imgX{1} = [obj.border + 1, obj.border + imgDims{2}(1)];
            imgY{1} = [obj.border + 1, obj.border + imgDims{1}(1)];
            imgX{2} = [imgX{1}(2) + 1, imgX{1}(2) + imgDims{2}(2)];
            imgY{2} = [obj.border + 1, obj.border + imgDims{1}(2)];
            
            for i = 3:obj.n
                if mod(i,2) == 0
                    %i is even
                    imgX{i} = [imgX{1}(2) + imgDims{2}(2) - imgDims{2}(i) + 1, imgX{1}(2) + imgDims{2}(2)];
                    imgY{i} = [imgY{i-2}(2) + 1, imgY{i-2}(2)+ imgDims{1}(i)];
                    
                else
                    %i is odd 
                    imgX{i} = [imgX{i-2}(2) + 1, imgX{i-2}(2) + imgDims{2}(i)];
                    imgY{i} = [imgY{1}(2) - imgDims{1}(i) + 1, imgY{1}(2)];
                end
            end
             
        end
                 
        function collage = imgNoUniPlace(obj, frame)
            [imgX, imgY] = obj.imgNoUniPosition(obj.patternNoUniCol);
            
            for i = 1:obj.n
                frame(imgY{i}(1):imgY{i}(2), imgX{i}(1):imgX{i}(2),:) = imresize(obj.imgContainer{i}, [obj.patternNoUniCol{1}(i), obj.patternNoUniCol{2}(i)]);
            end
            collage = frame;
        end
        
    
    end
    
end
    
    
    

