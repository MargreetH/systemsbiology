function [metric,valid] = handleSolutions(xL1,solL1, state1, xL2, solL2, state2)

valid = false;
metric = 0.25;

if (state1 == false) | (state2 == false) %something went wrong with solving the odes
   return;
end

if (~isreal(solL1)) | (~isreal(solL2)) %exclude solutions that have imaginary parts
    return;
end

if (size(xL1) == [1 1]) %something went wrong with solving the odes
    return;
end

M1 = solL1(:,1);
M2 = solL2(:,1);


L1valid = checkBiologicalValidity(M1,xL1,100);
L2valid = checkBiologicalValidity(M2,xL2,200);

if (~L1valid | ~L2valid)
    return;
end

valid = true;

%Calculate scoring metric
I1 = findIndexForFractionOfX(xL1,100, 0.25);
I2 = findIndexForFractionOfX(xL1,100, 0.50);
I3 = findIndexForFractionOfX(xL1,100, 0.75);

M1m = M1(I1);
M2m = M1(I2);
M3m = M1(I3);

y1 = xL1(I1)/100;
y2 = xL1(I2)/100;
y3 = xL1(I3)/100;

[I1, difference1] = findClosestValueIndex(M2, M1m);
[I2, difference2] = findClosestValueIndex(M2, M2m);
[I3, difference3] = findClosestValueIndex(M2, M3m);

y1star = xL2(I1)/200;
y2star = xL2(I2)/200;
y3star = xL2(I3)/200;

epsilon = 0.00001;
if difference1 > epsilon || difference2 > epsilon || difference3 > epsilon
    disp('too large difference');
    metric = 0.25;
else
metric = 1/3 * (abs(y1-y1star)+abs(y2-y2star)+abs(y3-y3star));
end

end