% Convert an image to a VHDL compatible input file
function img_to_vhdl_txt(grayscale_img,filename)
    % Invert image.
    grayscale_img = grayscale_img';
    % Columnize the image and convert each pixel to a 4 digit hex string
    hex_stream = cellstr(num2str(grayscale_img(:),'%04x'));
    % write out file using new line as the delimter
    dlmwrite(filename, hex_stream, '-append', 'delimiter', '', 'newline', 'pc');
end