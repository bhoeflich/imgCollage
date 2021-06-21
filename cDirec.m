
function path = cDirec(msg)
%info:
    %gets path of folder with images
%return
    %format: string with absolute path of folder
%input args:
    %msg is a promt 
%usage:
    %uniformCol noUniformCol

fprintf(msg);
path = uigetdir;

%maybe not recursive???
if path == 0
    path = cDirec('Try again! Choose a directory with images: \n');  
end

end

    

   
