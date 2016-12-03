function H = getHistogram(magnitudes, angles, numBins)

    % GETHISTOGRAM Computes a histogram for the supplied gradient vectors.
    %   H = getHistogram(magnitudes, angles, numBins)
    %
    %   This function takes the supplied gradient vectors and places them into a
    %   histogram with 'numBins' based on their unsigned orientation.
    %
    %   "Unsigned" orientation means that, for example, a vector with angle
    %   -3/4 * pi will be treated the same as a vector with angle 1/4 * pi.
    %
    %   Each gradient vector's contribution is split between the two nearest bins,
    %   in proportion to the distance between the two nearest bin centers.
    %
    %   A gradient's contribution to the histogram is equal to its magnitude;
    %   the magnitude is divided between the two nearest bin centers.
    %
    %   Parameters:
    %     magnitudes - A column vector storing the magnitudes of the gradient
    %                  vectors.
    %     angles     - A column vector storing the angles in radians of the
    %                  gradient vectors (ranging from -pi to pi)
    %     numBins    - The number of bins to place the gradients into.
    %   Returns:
    %     A row vector of length 'numBins' containing the histogram.

    % $Author: ChrisMcCormick $    $Date: 2013/12/04 22:00:00 $    $Revision: 1.2 $

    % Revision Notes:
    %  v1.2
    %    - Expanded '+=' since this gave Matlab users trouble.
    %  v1.1
    %    - The function was actually hardcoded to 9 bins; it now properly supports
    %      specifying 'numBins'.
    %    - It now returns an unsigned histogram. This has been shown to improve
    %      accuracy for person detection.

    % Histogram of cell
    H = zeros(numBins, 1);
    
    % Compute the bin size in radians. 180 degress = pi.
    binSize = pi / numBins;

    % Compute the histogram
    cellSize2 = 64;     %   cellSize^2
    d10  = pi/180*10;   %   binSize/2
    
    % Bin centers
    d30  = d10  + binSize;
    d50  = d30  + binSize;
    d70  = d50  + binSize;
    d90  = d70  + binSize;
    d110 = d90  + binSize;
    d130 = d110 + binSize;
    d150 = d130 + binSize;
    d170 = d150 + binSize;
       
    for ii = 1 : cellSize2
        % Make the angles unsigned by adding pi to all negative angles.
        if  angles(ii) < 0
            angles(ii) = angles(ii) + pi;
        end
        
        % Gradient angle may lie between two bin centers. For each pixel,
        % split the bin contributions between these two bins based on how
        % far the angle is from the bin centers.
        if      angles(ii) >= 0    && angles(ii) < d10
                rightPortion = (angles(ii) + d10 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(9) = H(9) + leftPortion ;
                H(1) = H(1) + rightPortion;
        elseif  angles(ii) >= d10  && angles(ii) < d30
                rightPortion = (angles(ii) - d10 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(1) = H(1) + leftPortion ;
                H(2) = H(2) + rightPortion;
        elseif  angles(ii) >= d30  && angles(ii) < d50
                rightPortion = (angles(ii) - d30 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(2) = H(2) + leftPortion ;
                H(3) = H(3) + rightPortion;
        elseif  angles(ii) >= d50  && angles(ii) < d70
                rightPortion = (angles(ii) - d50 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(3) = H(3) + leftPortion ;
                H(4) = H(4) + rightPortion;
        elseif  angles(ii) >= d70  && angles(ii) < d90
                rightPortion = (angles(ii) - d70 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(4) = H(4) + leftPortion ;
                H(5) = H(5) + rightPortion;
        elseif  angles(ii) >= d90  && angles(ii) < d110
                rightPortion = (angles(ii) - d90 )/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(5) = H(5) + leftPortion ;
                H(6) = H(6) + rightPortion;
        elseif  angles(ii) >= d110 && angles(ii) < d130
                rightPortion = (angles(ii) - d110)/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(6) = H(6) + leftPortion ;
                H(7) = H(7) + rightPortion;
        elseif  angles(ii) >= d130 && angles(ii) < d150
                rightPortion = (angles(ii) - d130)/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(7) = H(7) + leftPortion ;
                H(8) = H(8) + rightPortion;
        elseif  angles(ii) >= d150 && angles(ii) < d170
                rightPortion = (angles(ii) - d150)/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(8) = H(8) + leftPortion ;
                H(9) = H(9) + rightPortion;
        else
                rightPortion = (angles(ii) - d170)/binSize * magnitudes(ii);
                leftPortion  = magnitudes(ii) - rightPortion;
                H(9) = H(9) + leftPortion ;
                H(1) = H(1) + rightPortion;
        end
    end

end