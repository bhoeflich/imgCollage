function frame = buildFrame(rowsCol, colsCol, maxImgHeight, maxImgWidth, border)
%Erstellt den Schwarzen Hintergrung
%Border Input über uniformCollage Methode

height = (rowsCol * maxImgHeight) + border * (rowsCol + 1);
width = (colsCol * maxImgWidth) + border * (colsCol + 1);

frame = uint8(zeros(height, width , 3));
end


