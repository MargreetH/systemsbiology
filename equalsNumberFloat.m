function y = equalsNumberFloat(a,b, epsilon)
 lowerbound = a - epsilon;
 upperbound = a + epsilon;
 cond1 = b > lowerbound;
 cond2 = b < upperbound;
 
 if (cond1 && cond2)
     y = true;
 else
     y = false;
 end


end