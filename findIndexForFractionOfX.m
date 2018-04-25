function y = findIndexForFractionOfX(x,L,fraction)

numbertoFind = fraction*L;

if x(end) < numbertoFind
    y = length(x); %return last number
else
    y = findClosestValueIndex(x, numbertoFind);
end

end