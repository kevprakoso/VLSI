function M = magIterative(dx,dy)

    m = dx^2 + dy^2;
    x = 1; % initial guess
    xp = 0; % Initial previous
    while abs(x-xp) > 1e-4
            xp = x; % store previous value
            x = 0.5 * (x + m/x);
    end
    M = x;
    
end
