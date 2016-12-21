function H = getHOGDescriptorTestGaussianWindow(img, mask)

    % GETHOGDESCRIPTOR computes a HOG descriptor vector for the supplied image.
    %   H = getHOGDescriptor(img)
    %  
    %   This function takes a 130 x 66 pixel gray scale image (128 x 64 with a 
    %   1-pixel border for computing the gradients at the edges) and computes a 
    %   HOG descriptor for the image, returning a 3,780 value column vector.
    %
    %   Parameters:
    %     img - A grayscale image matrix with 130 rows and 66 columns.
    %   Returns:
    %     A column vector of length 3,780 containing the HOG descriptor.
    %
    %    The intent of this function is to implement the same design choices as
    %    the original HOG descriptor for human detection by Dalal and Triggs.
    %    Specifically, I'm using the following parameter choices:
    %      - 8x8 pixel cells
    %      - Block size of 2x2 cells
    %      - 50% overlap between blocks
    %      - 9-bin histogram
    %
    %     The above parameters give a final descriptor size of 
    %     7 blocks across x 15 blocks high x 4 cells per block x 9 bins per hist
    %     = 3,780 values in the final vector.
    %
    %    A couple other important design decisions:
    %    - Each gradient vector splits its contribution proportionally between the
    %      two nearest bins
    %    - For the block normalization, I'm using L2 normalization.
    %
    %    Differences with OpenCV implementation:
    %    - OpenCV uses L2 hysteresis for the block normalization.
    %    - OpenCV weights each pixel in a block with a gaussian distribution
    %      before normalizing the block.
    %    - The sequence of values produced by OpenCV does not match the order
    %      of the values produced by this code.

    % $Author: ChrisMcCormick $    $Date: 2013/12/04 22:00:00 $    $Revision: 1.2 $

    % Revision Notes:
    %  v1.2
    %    - Bug fix: Changed call from 'getUnsHistogram' to 'getHistogram'.
    %    - Replaced 'rows' and 'columns' calls with 'size' for Matlab users.
    %  v1.1
    %    - Changed the 'hy' filter mask to match the OpenCV filter mask (it's now
    %      [-1; 0; 1] instead of [1; 0; -1]).
    %    - Added a required one-pixel border around the image for computing
    %      gradients for the edge pixels.
    
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

    % Create the operators for computing image derivative at every pixel.
    hx = [-1  0  1];
    hy = [-1; 0; 1];

    % Compute the derivative in the x and y direction for every pixel.
    img = img(3:132, 3:68);
    dx = imfilter(img, hx);
    dy = imfilter(img, hy);

    % Remove the 1 pixel border.
    dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));  % 128 x 64
    dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1));  % 128 x 64

    % Convert the gradient vectors to polar coordinates (angle and magnitude).
    dx = double(dx);
    dy = double(dy);
    angles = atan2(dy, dx);             % 128 x 64
    magnit = ((dy.^2) + (dx.^2)).^.5;   % 128 x 64
    
    % Compute HOG for each block (15 vertical blocks x 7 horizontal blocks)
    for rr = 1 : (numVerticalCells - 1)
        row = (rr-1)*cellSize + 1;
        for cc = 1 : (numHorizonCells - 1)
            col = (cc-1)*cellSize + 1;
            angBlock  = angles(row:row+15, col:col+15);         % 16 x 16
            magBlock  = magnit(row:row+15, col:col+15) .* mask; % 16 x 16
            magBlock1 = magBlock(1:8,  1:8 );   % 8 x 8
            magBlock2 = magBlock(1:8,  9:16);   % 8 x 8
            magBlock3 = magBlock(9:16, 1:8 );   % 8 x 8
            magBlock4 = magBlock(9:16, 9:16);   % 8 x 8
            angBlock1 = angBlock(1:8 , 1:8 );   % 8 x 8
            angBlock2 = angBlock(1:8 , 9:16);   % 8 x 8
            angBlock3 = angBlock(9:16, 1:8 );   % 8 x 8
            angBlock4 = angBlock(9:16, 9:16);   % 8 x 8
            hist1 = getHistogram(magBlock1(:), angBlock1(:), numBins);  %  9 x 1
            hist2 = getHistogram(magBlock2(:), angBlock2(:), numBins);  %  9 x 1
            hist3 = getHistogram(magBlock3(:), angBlock3(:), numBins);  %  9 x 1
            hist4 = getHistogram(magBlock4(:), angBlock4(:), numBins);  %  9 x 1
            blockHists = [hist1; hist2; hist3; hist4];                  % 36 x 1
            magnitude = norm(blockHists(:)) + 0.00000001;
            normalized = blockHists / magnitude;                        % 36 x 1
            H = [H; normalized(:)];
        end
    end
    
end
