function H = getHistogramv2(dx,dy, mask)

    magnitudes = (abs(dx) + abs(dy)).*mask;
    numBins = 9;
    % Histogram of cell
    H = zeros(numBins, 1);
    
    % Compute the bin size in radians. 180 degress = pi.
    binSize = pi / numBins;

    % Compute the histogram
    cellSize2 = 64;     %   cellSize^2
    d20  = pi/180*20;   %   binSize/2
    
    % Bin centers
    d40  = d20  + binSize;
    d60  = d40  + binSize;
    d80  = d60  + binSize;
    d100  = d80  + binSize;
    d120 = d100  + binSize;
    d140 = d120 + binSize;
    d160 = d140 + binSize;
    d180 = d160 + binSize;
    
    dx = abs(dx);
    dy = abs(dy);


    for ii = 1 : cellSize2
        if dy(ii) >= dx(ii)*0    && dy(ii) < dx(ii)*tan(d20)
            H(1) = H(1) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d20)    && dy(ii) < dx(ii)*tan(d40)
            H(2) = H(2) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d40)    && dy(ii) < dx(ii)*tan(d60)
            H(3) = H(3) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d60)    && dy(ii) < dx(ii)*tan(d80)
            H(4) = H(4) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d80)    && dy(ii) < dx(ii)*tan(d100)
            H(5) = H(5) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d100)    && dy(ii) < dx(ii)*tan(d120)
            H(6) = H(6) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d120)    && dy(ii) < dx(ii)*tan(d140)
            H(7) = H(7) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d140)    && dy(ii) < dx(ii)*tan(d160)
            H(8) = H(8) + magnitudes(ii);
        elseif dy(ii) >= dx(ii)*tan(d160)    && dy(ii) < dx(ii)*tan(d180)
            H(9) = H(9) + magnitudes(ii);

    end

end