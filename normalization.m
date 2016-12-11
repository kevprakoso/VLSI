function norms = normalization(Hist)

	[row , col] = size(Hist);
	sums = 0;
	v=0;

	for ii = 1 : row
		sums = sums + Hist(ii);
	end

	n = floor(log2(sums));

	e   = 2^n;
	a	= 2^(n-1);

	b1 = a + 1*(e-a)/4;
	b2 = a + 2*(e-a)/4;
	b3 = a + 3*(e-a)/4;

	if sums > a && sums <= b1
		v= b1;
	elseif sums > b1 && sums <= b2
		v=b2;
	elseif sums > b2 && sums <= b3
		v=b3;
	elseif sums > b3&& sums <= e
		v=e ;
	end

	norms = Hist/v;

end