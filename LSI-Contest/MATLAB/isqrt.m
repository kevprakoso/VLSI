function M = isqrt(dx, dy ) 
    
    m = dx^2 + dy^2;
    res = 0;
    a = 1;
    bit = bitshift(a,14); % The second-to-top bit is set: 1 << 30 for 32 bits
 
    % "bit" starts at the highest power of four <= the argument.
    while (bit > m)
        bit = bitshift(bit, -2);
    end
    while (bit ~= 0) 
        if (num >= res + bit) 
            num = num - (res + bit);
            res = bitshift(res,-1) + bit;       
        else
            res = bitshift(res,-1);
            bit = bitshift(bit,-2);
        end
    end
    M = res;
end