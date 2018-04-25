function y = checkBiologicalValidity(M,x,L)

tresholdValueConcentration = 10^(-6);

y = false;

%Check first condition: M must be maximum and minimum at x=L

if (M(1) < max(M))
    return;
end

if (M(end) > min(M))
    return;
end



I = findIndexForFractionOfX(x,L, 0.5);
valueAt0_5L = M(I);
I = findIndexForFractionOfX(x,L, 0.75);
valueAt0_75L = M(I);
I = findIndexForFractionOfX(x,L, 0.25);
valueAt0_25L = M(I);

cond1 = valueAt0_5L < tresholdValueConcentration;
cond2 = valueAt0_75L < tresholdValueConcentration;

if (cond1) | (cond2)
    return;
end


ratio = max(M)/valueAt0_25L;

cond1 = ratio > 1;
cond2 = ratio < 100;

if (~cond1) | (~cond2)
    return;
end



y = true;


end