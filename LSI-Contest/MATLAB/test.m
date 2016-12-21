imageName = 'test_pos_1.png';
img = imread(imageName);
img1 = greyscale(img);
img_to_vhdl_txt(img1,'test_pos_1.raw');