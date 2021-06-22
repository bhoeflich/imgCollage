classdef picCollage
    
    properties  
        n
        % number of picturs in collage
        
        border
        % border in px around collage (uniform: between pictures)
        
        imgDirPath 
        % string with the absolute path to direct. with images
        
        imgLst
        % cell array that all contains absolute paths to images 
        
        imgContainer
        % cell array that contains n uint8 pictures
        
        imgMaxSize
        % dimensions of largest image
        
        img1Size
        % dimensions of first image
        
        pattCol
        % pattern of uniform collage 
    end
    
    methods
        %______________ main methods to generate collages ______________
        
        function obj = picCollage(n, border)
            
            obj.n = n;
            % is set when a instance of picCollage is created
            
            obj.border = border;
            % is set when a instance of picCollage is created
            
            obj.imgDirPath = cDirec('Choose a directory with images : \n');
            % cDirec is a static function that returns absolute path of
            % chosen directory to imgDirPath 
            % no matter which OS!!
            
            obj.imgLst = listDirs(obj.imgDirPath);
            % listDirs is a function that returns an cell array 
            % to imgLst with all absolute paths to the files in imgDirPath
            % no matter which OS!!
            
            obj.imgContainer = obj.loadImgs;
            % loads n images into imgContainer stored into cell array  
            
            obj.imgMaxSize = obj.maxSize;
            % imgMaxSize finds dimensions of largest image in imgConatiner
            % returns it as a vector [1x2] (only used for uniformCol)
          
            obj.img1Size = size(obj.imgContainer{1});
            % imgMaxSize finds dimensions of first image in imgConatiner
            % returns it as a vector [1x2] (only used for noUniformCol)
            
            obj.pattCol = obj.patternCol();
            % pattern col generates pattern for uniformCol
            
        end
        
       
        %______________ main methods to generate collages ______________
        
        function collage = uniformCol(obj)
            %info:
                % creates collage with images of same size 
            %return
                %format: unint8 image 
            %input args:
                %--
            %usage:
                %uniformCol
                
            collage = imgUniPlace(obj, buildFrame(obj.calcUniFrame()));
            
            image(collage)
            axis image
            axis equal
            axis off
            
        end
        
        function collage = noUniformCol(obj)
            %info:
                % creates collage with images, image of the next picture is
                % always halve the size of the one before 
            %return
                %format: unint8 image 
            %input args:
                %--
            %usage:
                %noUniformCol
                
            collage = imgNoUniPlace(obj, buildFrame(obj.calcNoUniFrame()));
            
            image(collage)
            axis image
            axis off
        end
        
    end
    
    methods (Access = private)
        
        %______________ functions to initilazie properties _____________ 
        
        function directories = listDirs(obj)
            %info:
                % returns a list of all absolute paths to the files in imgDirPath
                % no matter which OS you are using
            %return
                %format: cell of strings
            %input args:
                %--
            %usage:
                %uniformCol, noUniformCol
                
            tempStruct = dir(obj.imgDirPath);
            
            directories = fullfile({tempStruct(3:obj.n).folder}, {tempStruct(3:obj.n).name});
        end
        
        function Container = loadImgs(obj)
            %info:
                % returns cell array with n images
            %return
                %format: cell array with uint8 in every cell 
            %input args:
                %--
            %usage:
                %uniformCol
            
            Container = cell(1, obj.n);
            for i = 1:obj.n
                Container{i} = imread(char(obj.imgLst(i)));
                %To Do:
                %Was passiert wenn n groesser als Anzahl der Objekte in obj.imgLst!!!!!!!
                %if Abfrage
            end
        end
  
        function maxImgDim = maxSize(obj)
            %info:
                % returns dimensions (height, width) of largest picture
            %return
                %format: vector [1x2] 
            %input args:
                %--
            %usage:
                %uniformCol
            
            for i = 1:length(obj.imgContainer)
                [imgHeight(i), imgWidth(i), clrs(i)] = size(obj.imgContainer{i});
            end
            
            maxImgDim = [max(imgHeight), max(imgWidth)];
        end
        
        
        %______________ functions executed in main methods _____________
        
       
        function collage = imgUniPlace(obj, frame)
             %info:
                %places pictures on background frame and returns collage
            %return
                %format: uint8 frame (black background) with pictures on   
            %input args:
                %frame: generated by buildFrame function
            %usage:
                %uniformCol
            
            [imgX, imgY] = obj.imgUniPosition();
            
            counter = 1;
            for row = 1:length(imgY)
                for col = 1:length(imgX)
                    if counter <= obj.n
                        frame(imgY{row}(1):imgY{row}(2), imgX{col}(1):imgX{col}(2),:) ...
                                = imresize(obj.imgContainer{counter}, obj.imgMaxSize);
                        counter = counter +1;
                    end
                    
                end
            end
            collage = frame;
        end 
        
        function collage = imgNoUniPlace(obj, frame)
            %info:
                %places pictures on background frame and returns collage
            %return
                %format: uint8 frame (black background) with pictures on   
            %input args:
                %frame: generated by buildFrame function
            %usage:
                %noUniformCol
            
            
            [imgX, imgY] = obj.imgNoUniPosition(obj.patternNoUniCol);
            
            for i = 1:obj.n
                frame(imgY{i}(1):imgY{i}(2), imgX{i}(1):imgX{i}(2),:) = imresize(obj.imgContainer{i}, [obj.patternNoUniCol{1}(i), obj.patternNoUniCol{2}(i)]);
            end
            collage = frame;
        end
        
        function [imgX, imgY] = imgUniPosition(obj)
            %info:
                %calculates the start and end points on x,y axis of
                %each picture
            %return
                %format: vector with [1x2] vectors in it  
            %input args:
                %--
            %usage:
                %uniformCol
            
            for c = 1:obj.pattCol(2)
                imgX{c} = [(((obj.border + 1) + ((c-1) * (obj.border) + ((c-1) * (obj.imgMaxSize(2)))))), ((c * obj.border) + (c * (obj.imgMaxSize(2))))];
            end
            
            for r = 1:obj.pattCol(1)
                imgY{r} = [(((obj.border + 1) + ((r-1) * (obj.border) + ((r-1) * (obj.imgMaxSize(1)))))), ((r * obj.border) + (r * (obj.imgMaxSize(1))))];
            end
            imgY = transpose(imgY);
            
        end
        
        function [imgX, imgY] = imgNoUniPosition(obj, imgDims)
            %info:
                %calculates the start and end points on x,y axis of
                %each picture
            %return:
                %format: vector with [1x2] vectors in it  
            %input args:
                %imgDims
            %usage:
                %noUniformCol
                
            
            if obj.img1Size(1) >= obj.img1Size(2)
                % when first picture is portait format
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
            
            else
                %when first picture is in landscape format 
                
            end
            
            
        end
        
        function pattCol = patternCol(obj)
            %info:
                % that calculates rows and columns
            %return:
                %format: vector 1x2, info about rows and collumns of collage
            %input args:
                %--
            %usage:
                %uinformCol
            
           
            %{
            colsCol = 3;
            if mod(obj.n , colsCol) == 0
                rowsCol = obj.n/colsCol;
            else
                rowsCol = ceil(obj.n/colsCol);
            end
            %Vektot mit Anzahl der Reihen und Spalten der Collage
            pattCol = [rowsCol, colsCol];
            %}
         
            %Orientation in horizontal or vertical direction via input
            
            s1 = 'H';
            s2 = input('Choose orientation: Type "H" for Horizontal or "V" for Vertical\n', 's');
            
            %If Number of pictures is even rows and colums are of equal size, else,
            %depending on the orientation chosen the rows or colums are rounded up or
            %down, additional control whether enough space for number of pictures, if
            %not row or column is added
            
            if mod(obj.n, sqrt(obj.n)) == 0
                rowsCol = sqrt(obj.n);
                colsCol = sqrt(obj.n);
            else
                if strcmp(s1, s2) == 1
                    rowsCol = floor(sqrt(obj.n));
                    colsCol = ceil(sqrt(obj.n));
                    
                    if colsCol * rowsCol < obj.n
                        colsCol = colsCol +1;
                    end
                    
                else
                    rowsCol = ceil(sqrt(obj.n));
                    colsCol = floor(sqrt(obj.n));
                    
                    if colsCol * rowsCol < obj.n
                        rowsCol = rowsCol +1;
                    end
                end
            end
            pattCol = [rowsCol, colsCol];
        end
        
        function imgDims = patternNoUniCol(obj)
            %info:
                %calculates height and width of each picture in noUniformCol
            %return
                %format: cell array with vectors in it 
            %input args:
                %--
            %usage:
                %noUniformCol
            
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
        
        function frameDims = calcUniFrame(obj)
            %info:
                %calculates the dimensions of the background frame
            %return
                %format: vector 1x2, info about height, width 
            %input args:
                %--
            %usage:
                %uniformCol noUniformCol
                
            height = (obj.pattCol(1) * obj.imgMaxSize(1)) + obj.border * (obj.pattCol(1) + 1);
            width = (obj.pattCol(2) * obj.imgMaxSize(2)) + obj.border * (obj.pattCol(2) + 1);
            frameDims = [height, width];
        end
        
        function frameDims = calcNoUniFrame(obj)
            %info:
            %calculates dimensions of the background frame for noUniformCol
            %return
                %format: vector 1x2, info about height, width
            %input args:
                %--
            %usage:
                %noUniformCol
            
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
end
   
    
    
end
    
    
    

