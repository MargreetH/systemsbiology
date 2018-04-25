%Position should be specified as x*L, checks if the solution does not
%deviate much
function passed = steadyStateCheck(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T_p2, h ,p_2, x, E, M, position)


dt = 1; %time step
fulltime = 5*10^5;
halftime = fulltime / 2;

%extract the values for M and E
index = findIndexForFractionOfX(x,position,1);
singleE= E(index);
singleM = M(index);

%Get the second order difference
diffE2 = gradient(gradient(E));
diffM2 = gradient(gradient(M));

difE2 = diffE2(index);
difM2 = diffM2(index);



%Define variables to store the averages.
sumE = 0;
sumM = 0;

for i = 1:1:fulltime
    
    %Store the values if we are at or past t1/2
    if i >= halftime
        sumE = sumE + singleE;
        sumM = sumM + singleM;
    end
    
    %Update the solution
    singleM = dt * (D_M * difM2 - (1 + singleE)^p_1 * alpha_1 * singleM - (1 + singleE)^p_1 * alpha_2 * singleM^2);
    singleE = dt * (D_E * difE2 - alpha_E * singleE + beta_E * (singleM/T_p2)^(h*p_2)/(1+(singleM/T_p2)^h));
    
end

%Calculate time average
avgM = sumM / halftime;
avgE = sumE / halftime;

deviationM = abs(avgM - singleM);
deviationE = abs(avgE - singleE);

cond1 = deviationM < 0.01;
cond2 = deviationE < 0.01;

if cond1 && cond2
    passed = true;
else
    passed = false;
end


end