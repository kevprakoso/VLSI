clear all
close all
clc

%%  Find windows including objects at multiple positions and scales    
load gaussianWindow.mat
load SVMModelRetrain_16_06_08_BC_0_010.mat
load Hi_Hi_inv_16_09_13_scale_1.25.mat  % scale = 1.25

% Read input image
imageName = 'test_pos_1.png';
img = imread(imageName);
[ rows, cols, z ] = size(img);

% Convert input image into Grayscale image
if  z > 1
    img1 = rgb2gray(img);
else
    img1 = img;
end

% Calculate number of scale step to scan over input image
% using ratio scale = 1.25
startScale   =   1;
endScale     = min( rows/134, cols/70 );
ratioScale   = 1.25;
nScaleSteps  = floor( log10(endScale/startScale) / log10(ratioScale) + 1 );

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
    imgSi = imresize(img1, 1/scaleSi, 'bilinear');
    [ rowSi, colSi ] = size(imgSi);
    
    for rr = 1 : 8 : rowSi-133
        for cc = 1 : 8 : colSi-69
            % Compute HOG descriptor for one image window and classify it
            imgTemp = imgSi( rr:rr+133, cc:cc+69 );
            H = getHOGDescriptorTestGaussianWindow(imgTemp, mask);
            score = H' * w + b; %Transpose and multiply (matrice-ly) and add b
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
    
    
    %% Fusion of multiple detects
    % Find mode of each detects    
    y         = detects(:, 1:3);
    scaleInd  = detects(:, 4);
    tw        = detects(:, 5);
    
    ym = zeros(nDetects, 4);
    for nn = 1 : nDetects
        ym_nn     = [y(nn, :) 0];
        for iter = 1 : 5
            D       = zeros(1, nDetects);
            wi_deno = D;
            wi      = D;
            wi_nume = 0;
            for ii = 1 : nDetects
                tmp_ym_yi = ym_nn(1:3) - y(ii, :);
                D(ii) = tmp_ym_yi * Hi_inv( :, :, scaleInd(ii) ) * tmp_ym_yi';
                wi_deno(ii) = Hi_det( scaleInd(ii) ) * tw(ii) * exp( -D(ii)/2 );
                wi_nume = wi_nume + wi_deno(ii);
            end
            
            Hh_inv  = zeros(3, 3);
            Hh      = Hh_inv;
            ym_tmp  = zeros(3, 1);
            for ii = 1 : nDetects
                wi(ii) = wi_deno(ii) / wi_nume;
                wi_Hi_inv_tmp = wi(ii) * Hi_inv( :, :, scaleInd(ii) );
                Hh_inv = Hh_inv + wi_Hi_inv_tmp;
                ym_tmp = ym_tmp + wi_Hi_inv_tmp * y(ii, :)';
            end
            
            Hh(1, 1) = 1 / Hh_inv(1, 1);
            Hh(2, 2) = 1 / Hh_inv(2, 2);
            Hh(3, 3) = 1 / Hh_inv(3, 3);
            
            ym_nn = [(Hh * ym_tmp)' nn];
        end
        ym(nn, :) = ym_nn;
    end
    
    nDetects_test_2 = size(ym, 1);
    coordinates = zeros(nDetects_test_2, 5);
    for ii = 1 : nDetects_test_2
        ss = 10^ym(ii, 3);
        ww = floor(  69*ss );
        hh = floor( 133*ss );
        xx = floor( ym(ii, 2)*ss );
        yy = floor( ym(ii, 1)*ss );
        coordinates(ii, :) = [xx yy xx+ww yy+hh ii];
    end
    
    % Find detects with same mode and cluster them
    [~, ind1] = sort(coordinates(:, 1), 'descend');
    coordinates1  = coordinates(ind1, :);
    
    flagNotInside = ones(nDetects, 1);
    for ii = 1 : nDetects - 1
        if  flagNotInside(ii) == 0
            continue
        end
        
        detect_ii = coordinates1(ii, :);
        
        for jj = ii+1 : nDetects
            if  flagNotInside(jj) == 0
                continue
            end
            
            detect_jj = coordinates1(jj, :);
            if      detect_ii(2) >= detect_jj(2) && ...
                    detect_ii(3) <= detect_jj(3) && ...
                    detect_ii(4) <= detect_jj(4)
                flagNotInside(ii) = 0;
                break
            elseif  detect_ii(1) == detect_jj(1) && ...
                    detect_ii(2) <= detect_jj(2) && ...
                    detect_ii(3) >= detect_jj(3) && ...
                    detect_ii(4) >= detect_jj(4)
                flagNotInside(jj) = 0;
                continue
            end
        end
    end
    
    coordinates2 = coordinates1(flagNotInside == 1, :);
    nDetects2 = size(coordinates2, 1);
    flagSameCluster = [1 : nDetects2]';
    for ii = 1 : nDetects2 - 1
        detect_ii = coordinates2(ii, :);
        for jj = ii+1 : nDetects2
            detect_jj = coordinates2(jj, :);
            if  abs( detect_ii(1) - detect_jj(1) ) < 60 && ...
                    abs( detect_ii(2) - detect_jj(2) ) < 60
                if  flagSameCluster(jj) < flagSameCluster(ii)
                    flagSameCluster(ii) = flagSameCluster(jj);
                else
                    flagSameCluster(jj) = flagSameCluster(ii);
                end
            end
        end
    end
    
    % Fuse detects in same cluster
    coordinates2(:, 5) = flagSameCluster;
    finalDetects_tmp = zeros(nDetects2, 4);
    ind_final = zeros(nDetects2, 1);
    for ii = 1 : nDetects2
        tmp   = [0 0 0 0];
        count = 0;
        for jj = 1 : nDetects2
            if  coordinates2(jj, 5) == ii
                tmp = tmp + coordinates2(jj, 1:4);
                count = count + 1;
            end
        end
        
        if  count ~= 0
            finalDetects_tmp(ii, :) = floor(tmp / count);
            ind_final(ii) = 1;
        else
            finalDetects_tmp(ii, :) = tmp;
        end
    end
    finalDetects = finalDetects_tmp(ind_final == 1, :);
    
    %% Draw bounding boxes
    figure
    imshow(img)
    title('Final Detects')
    hold on
    
    nFinalDetects = size(finalDetects, 1);
    for ii = 1 : nFinalDetects
        xx = finalDetects(ii, 1);
        yy = finalDetects(ii, 2);
        ww = finalDetects(ii, 3) - xx;
        hh = finalDetects(ii, 4) - yy;
        rectangle('Position', [xx, yy, ww, hh], 'EdgeColor', 'r');
        text(xx, yy, num2str(ii))
    end
    
end

