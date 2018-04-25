%Takes an array and sets all negative elements to zero
function y = setNegativeElementsToZero(array)

y = array;

for i=1:1:length(array)
    if array(i) < 0
        y(i) = 0;
    end
end

end