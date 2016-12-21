% Convert an image to a VHDL compatible input file
function img_to_vhdl_txt(img,filename)
    % Invert image.
    img_red = (img(:,:,1))';
    img_green = (img(:,:,2))';
    img_blue = (img(:,:,3))';    
    % Columnize the image and convert each pixel to a 4 digit hex string
    hex_stream_red = cellstr(num2str(img_red(:),'%02x'));
    hex_stream_green = cellstr(num2str(img_green(:),'%02x'));
    hex_stream_blue = cellstr(num2str(img_blue(:),'%02x'));
    hex_stream_1 = strcat(hex_stream_red, hex_stream_green);
    hex_stream_2 = strcat(hex_stream_1, hex_stream_blue);
    % write out file using new line as the delimter
    dlmwrite(filename, hex_stream_2, '-append', 'delimiter', '', 'newline', 'pc');
end