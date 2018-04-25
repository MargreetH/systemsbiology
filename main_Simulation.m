%%%%%% Variables
clear all; close all; clc;

spacing = 5; %Amount of spacing for each vector.

D_M = logspace(-1,1,spacing); %1
D_E = logspace(-1,1,spacing);
alpha_1 = logspace(-5,0,spacing);
alpha_2 = logspace(-3,2,spacing);
alpha_E = logspace(-5,0,spacing);
nu = logspace(-1,1,spacing);
beta_E = logspace(-4,-2,spacing);
p_1 = [-1 1];

T_0 = logspace(-5,3,spacing);
T_1 = logspace(-1,1,spacing);
T =  horzcat(T_0,T_1);
h = 2:(3-2)/spacing:4;
L = [100 200];
maxTime = 5*10^5;

%Store correct parameters found in this vector, including scoring metric
numberOfParams = 11;
storedParams = zeros(1,numberOfParams);


totalTLength = length(T_0) + length(T_1);

% X and t scale
x1 = [0 L(1)];
x2 = [0 L(2)];

counter = 1;
totalCounter = 1;

% The biggest nested loop ever
for i = 1:1:length(D_M)
    for j = 1:1:length(D_E)
        for k = 1:1:length(alpha_1)
            for m = 1:1:length(alpha_2)
                for n = 1:1:length(alpha_E)
                    for o = 1:1:length(nu)
                        for p = 1:1:length(beta_E)
                            for q = 1:1:length(p_1)
                                for s = 1:1:length(h)

                                           if m == 2
                                               disp('Percentage of scanned parameters that were valid:');
                                               percentageValid = (counter / totalCounter) * 100;
                                               disp(percentageValid);
                                               return;
                                           end

                                           for v = 1:1:totalTLength
                                               
                                               totalCounter = totalCounter + 1;
                                               %Use correct value of p_2
                                               if v < length(T_0)
                                                   p_2 = 0;
                                               else
                                                   p_2 = 1;
                                               end
                                               
                                               
                                               %Actual calculations here,
                                               %solve for L = 100;
                                               [xL1,solL1, state1] = solveSystemPDEs(D_M(i), p_1(q), alpha_1(k), alpha_2(m), D_E(j), alpha_E(n), beta_E(p), T(v) ,h(s),p_2, nu(o), x1);
                                               [xL2,solL2, state2] = solveSystemPDEs(D_M(i), p_1(q), alpha_1(k), alpha_2(m), D_E(j), alpha_E(n), beta_E(p), T(v) ,h(s),p_2, nu(o), x2);
                                               
                                               %Check this solution for
                                               %validity.
                                               
                                               [metric,valid] = handleSolutions(xL1,solL1, state1, xL2, solL2, state2);

                                               if valid
                                                   
                                                    simulationAlsoValid1 = steadyStateCheckAllPositions(D_M(i), p_1(q), alpha_1(k), alpha_2(m), D_E(j), alpha_E(n), beta_E(p), T(v) ,h(s), p_2, xL1, solL1(:,2), solL1(:,1), 100);
                                                    simulationAlsoValid2 = steadyStateCheckAllPositions(D_M(i), p_1(q), alpha_1(k), alpha_2(m), D_E(j), alpha_E(n), beta_E(p), T(v) ,h(s), p_2, xL2, solL2(:,2), solL2(:,1), 200);
                                                   
                                                   if simulationAlsoValid1 && simulationAlsoValid2
                                                       %disp('passed all conditions, metric=');
                                                       %disp(metric);
                                                       %store this
                                                       %parameter set
                                                       storedParams(counter,:) = createParamVector(D_M(i), p_1(q), alpha_1(k), alpha_2(m), D_E(j), alpha_E(n), beta_E(p), T(v) ,h(s), p_2, metric);
                                                       counter = counter + 1;
                                                   else
                                                       disp('didnt pass simulation condition');
                                                   end
                                                   
                                               else
                                                   %disp('not valid')
                                               end
                                           end
                                   
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end





%%%%%%