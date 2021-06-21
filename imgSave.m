
function imgSave(collage)
%info:
    %saves collage to jpg file 
%return
    %--
%input args:
    %uint8 collage
%usage:
    %uniformCol noUniformCol

filename = input('Geben sie eine gültigen Dateinamen ein in folgendem Format ein:\ndateiname.jpg\n', 's');
imwrite(collage, filename)
end

