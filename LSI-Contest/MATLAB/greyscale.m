function grey = greyscale(img)
    grey = img(:,:,1)*0.3 + img(:,:,2)*0.6+ img(:,:,3)*0.1
end