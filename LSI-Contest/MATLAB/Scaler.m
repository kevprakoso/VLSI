function pict = Scaler(img, scale)
[rows, cols ] = size(img);
row1 = floor(rows/scale);
col1 = floor(cols/scale);
pict= zeros(row1,col1,'uint8');

    for i=1 : row1
        for j=1 : col1
        a = floor(scale*i);  
        b = floor(scale*j);
        pict(i,j) = img(a,b); 
        end
    end

end