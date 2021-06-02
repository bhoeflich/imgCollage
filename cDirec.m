
function path = cDirec(msg)
fprintf(msg);
path = uigetdir;

%if the user clicks cancel button
%uigetdir returns 0 
%maybe not recursive???
if path == 0
    path = cDirec('Try again! Choose a directory with images: \n');
end

   
