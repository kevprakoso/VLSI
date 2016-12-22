function res = sqr (val)
	
    mask = 1;
    factorsum = val;
    sum = 0;
    while (val >= mask)
        
        if ((and(val,mask) == mask))        
            sum = sum +  factorsum;       
        end
        factorsum = factorsum +  factorsum;
        mask = mask + mask;    
    end
    res = sum;
	