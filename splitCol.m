function [rowsCol, colsCol] = splitCol(n)
%Legt die Reihen und Spalten der Collage fest
%To Do
    %Spaltenanzahl nach n variabel machen 
colsCol = 3;
if mod(n , colsCol) == 0
    rowsCol = n/colsCol;
else
    rowsCol = ceil(n/colsCol);
end

    

            
