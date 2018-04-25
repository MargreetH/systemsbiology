function passed = steadyStateCheckAllPositions(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T_p2, h ,p_2, x, E, M, L)

passed = false;

positions = [0 0.25 0.5 0.75 1] * L;
x = x';
E = E';
M = M';

%disp(E);
%disp(M);

for i = 1:1:length(positions)
    condition = steadyStateCheck(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T_p2, h ,p_2, x, E, M, positions(i));
    if ~condition
       return; 
    end
end


passed = true;


end