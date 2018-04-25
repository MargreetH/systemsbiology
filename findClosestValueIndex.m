%Returns the index of the array value that is closest to the number
function [I, difference] = findClosestValueIndex(array, number)

differenceArray = array - number;
[~,I] = min(abs(differenceArray));
[difference,~] = min(abs(differenceArray));

end

