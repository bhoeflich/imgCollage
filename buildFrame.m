function frame = buildFrame(frameDims)
%info:
    %creates black background
%return
    %format: uint8, black color
%input args: 
    %frame dims: array of heigth and width of frame
%usage:
    %uniformCol, noUniformCol
    
frame = uint8(zeros(frameDims(1), frameDims(2) , 3));
end



