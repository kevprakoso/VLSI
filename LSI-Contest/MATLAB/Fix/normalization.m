function norms = normalization(Hist)

	[row , col] = size(Hist);
	sums = norm(Hist);

% 	for ii = 1 : row*col
% 		sums = sums + Hist(ii);
% 	end

	n = floor(log2(sums));

	e   = 2^(n+1);
	a	= 2^(n);

	b1 = a + 1*(a)/8;
	b2 = a + 2*(a)/8;
	b3 = a + 3*(a)/8;
    b4 = a + 4*(a)/8;
	b5 = a + 5*(a)/8;
	b6 = a + 6*(a)/8;
    b7 = a + 7*(a)/8;
    
	if ((sums) > a && (sums <= b1))
		v= b1;
	elseif ((sums > b1) && (sums <= b2))
		v=b2;
	elseif ((sums > b2) && (sums <= b3))
		v=b3;
    elseif ((sums > b3) && (sums <= b4))
		v=b4;
    elseif ((sums > b4) && (sums <= b5))
		v=b5;
    elseif ((sums > b5) && (sums <= b6))
		v=b6;
    elseif ((sums > b6) && (sums <= b7))
		v=b7;    
	elseif ((sums > b7) && (sums <= e))
		v=e ;
	end

	norms = (Hist/v);

end