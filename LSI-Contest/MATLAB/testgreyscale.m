% Convert an image to a VHDL compatible input file
function imggrey_to_vhdl_txt(img,filename)
    % Invert image.
    img = img';    
    % Columnize the image and convert each pixel to a 4 digit hex string
    hex_stream = cellstr(num2str(img(:),'%02x'));
    % write out file using new line as the delimter
    dlmwrite(filename, hex_stream, '-append', 'delimiter', '', 'newline', 'pc');
end

