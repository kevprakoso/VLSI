function n = CalculateScaleSteps(rows, cols)
    a = rows/134;
    b = cols/70;

    if a < b
       min = a;   
    else
       min = b; 
    end

    if min>=1 && min <1.25
        n = 1;
    elseif min>=1.25 && min<1.56
        n = 2;
    elseif min>=1.56 && min<1.95
        n = 3;
    elseif min>=1.95 && min<2.44
        n = 4;
    elseif min>2.44 && min<3.05
        n = 5;
    elseif min>3.05 && min<3.81
        n = 6;
    elseif min>3.81 && min<4.77
        n = 7;
    elseif min>4.77 && min<5.96
        n = 8;
    elseif min>5.96 && min<7.46
        n = 9;
    elseif min>7.46 && min<9.33
        n = 10;
    elseif min>9.33 && min<11.66
        n = 11;
    elseif min>11.66 && min<14.58
        n = 12;
    elseif min>14.58 && min<18.23
        n = 13;
    elseif min>18.23 && min<22.79
        n = 14;
    elseif min>22.79 && min<28.5
        n = 15;
    elseif min>28.5 && min<35.63
        n = 16;
    else
        n = 17;        
    end
end