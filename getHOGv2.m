function H = getHOGv2(img, mask)

    % The number of bins to use in the histograms.
    numBins = 9;

    % The cells are 8 x 8 pixels.
    cellSize = 8;

    % Empty vector to store computed descriptor.
    H = [];

%     % Verify the image size is 96 x 160.
%     [height, width] = size(img);
%     
%     if ((width ~= 70) || (height ~= 134))
%         disp('Image size must be 134 x 70 pixels (128x64 with 3px border).\n');
%         return;
%     end

    % Compute the number cells horizontally and vertically (should be 8 x 16).
    numHorizonCells  =  8;
    numVerticalCells = 16;

    % ===============================
    %    Compute Gradient Vectors
    % ===============================
    % Compute the gradient vector at every pixel in the image.

    [dx, dy] = gradient(img);


    % Convert the gradient vectors to polar coordinates (angle and magnitude).
    dx = double(dx);
    dy = double(dy);
    %angles = atan2(dy, dx);             % 128 x 64
    %magnit = abs(dx) + abs(dy);  % 128 x 64
    
    % Compute HOG for each block (15 vertical blocks x 7 horizontal blocks)
    for rr = 1 : (numVerticalCells - 1)
        row = (rr-1)*cellSize + 1;
        for cc = 1 : (numHorizonCells - 1)
            col = (cc-1)*cellSize + 1;
            dxBlock  = dx(row:row+15, col:col+15);         % 16 x 16
            dyBlock  = dy(row:row+15, col:col+15);         % 16 x 16
            dxBlock1 = dxBlock(1:8 , 1:8 );   % 8 x 8
            dxBlock2 = dxBlock(1:8 , 9:16);   % 8 x 8
            dxBlock3 = dxBlock(9:16, 1:8 );   % 8 x 8
            dxBlock4 = dxBlock(9:16, 9:16);   % 8 x 8
            dyBlock1 = dyBlock(1:8 , 1:8 );   % 8 x 8
            dyBlock2 = dyBlock(1:8 , 9:16);   % 8 x 8
            dyBlock3 = dyBlock(9:16, 1:8 );   % 8 x 8
            dyBlock4 = dyBlock(9:16, 9:16);   % 8 x 8
            
            hist1 = getHistogramv2(dxBlock1,dyBlock1, mask(1:8 , 1:8));  %  9 x 1
            hist2 = getHistogramv2(dxBlock2,dyBlock2, mask(1:8 , 9:16));  %  9 x 1
            hist3 = getHistogramv2(dxBlock3,dyBlock3, mask(9:16, 1:8));  %  9 x 1
            hist4 = getHistogramv2(dxBlock4,dyBlock4, mask(9:16, 9:16));  %  9 x 1
            blockHists = [hist1; hist2; hist3; hist4];                  % 36 x 1
            normalized = normalization(blockHists);                        % 36 x 1
            H = [H; normalized(:)];
        end
    end
    
end