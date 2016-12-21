clear all
close all
clc

%%  Find windows including objects at multiple positions and scales    
load gaussianWindow.mat
load SVMModelRetrain_16_06_08_BC_0_010.mat
load Hi_Hi_inv_16_09_13_scale_1.25.mat  % scale = 1.25

% Read input image
imageName = 'test_pos_3.png';
img = imread(imageName);
[ rows, cols, z ] = size(img);

% Convert input image into Grayscale image
img1 = greyscale(img);


% Calculate number of scale step to scan over input image
% using ratio scale = 1.25
startScale   =   1;
ratioScale   = 1.25;
nScaleSteps = CalculateScaleSteps(rows, cols);

scales = [ startScale zeros(1, nScaleSteps-1)];
for ii = 1 : nScaleSteps-1
    scales(ii+1) = startScale * ratioScale^ii;
end

% Classify each image window of size 134 x 70 pxl to be object/non-object
% using linear SVM classifier (specified by weight 'w' and bias 'b'
% b = b + 0.3214;
detects = [];
for Si = 1 : nScaleSteps
    % Resize input image at scale = 1/scaleSi
    scaleSi = scales(Si);
    ss = log10(scaleSi);
    imgSi = Scaler(img1, scaleSi);
    [ rowSi, colSi ] = size(imgSi);
    
    for rr = 1 : 8 : rowSi-133
        for cc = 1 : 8 : colSi-69
            % Compute HOG descriptor for one image window and classify it
            imgTemp = imgSi( rr:rr+133, cc:cc+69 );
            H = getHOGv2(imgTemp, mask);
            score = H' * w + b;
            if  score > 0
                detects = [detects; rr cc ss Si score];
                
            end
        end
    end
end

nDetects  = size(detects, 1);
if  nDetects == 0
    figure
    imshow(img)
    title('No human body in image')
else
    % Display detects -- before fusion of multiple detects
    figure
    imshow(img)
    title('Before fusion of multiple detects')
    hold on    
    
    for ii = 1 : nDetects
        ss = 10^detects(ii, 3);
        ww = floor(  69*ss );
        hh = floor( 133*ss );
        xx = floor( detects(ii, 2)*ss );
        yy = floor( detects(ii, 1)*ss );
        rectangle('Position', [xx, yy, ww, hh], 'EdgeColor', 'r');
        text(xx, yy, num2str(ii));
    end 
end