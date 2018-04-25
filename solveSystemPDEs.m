%Solves the two PDE's for a set of values.
function [solx,soly, state, solz] = solveSystemPDEs(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T_p2, h ,p_2, nu, xx)



%Stuff to quit trying to solve the DE when finding the solution takes too
%long
options = odeset('Events', @my_event_fcn); 
start_time = tic; 
epsilon = 0.00001;

curValue = [1 0]; % M and E
maxIterations = 100; %max Num of iterations
solx= 0;
soly =[];

state = true;

warnId = 'MATLAB:ode45:IntegrationTolNotMet';
warnstate = warning('error', warnId);    


try     
    [solx,solytemp]  = ode45(@vdp1F, xx, [curValue(1); -nu/D_M; curValue(2); 0], options);
catch ME
    state = false;
    % Check if we indeed failed on meeting the tolerances
    if strcmp(ME.identifier, warnId)
        return;

    else
        % Something else has gone wrong: just re-throw the error        
        throw(ME);
    end
    
end

% Don't forget to reset the warning status
warning(warnstate);

soly(:,1) = setNegativeElementsToZero(solytemp(:,1));
soly(:,2) = setNegativeElementsToZero(solytemp(:,3));

% exclude solutions that have nonzero derivatives at end
cond1 = equalsNumberFloat(solytemp(end,2),0, epsilon);
cond2 = equalsNumberFloat(solytemp(end,4),0, epsilon);
if (cond1 && cond2);
    state = false;
end

function dFdx = vdp1F(~,F)
dFdx = [F(2); (1+F(3))^p_1*alpha_1/D_M*F(1)+(1+F(3))^p_1*alpha_2/D_M*F(1)^2; F(4); alpha_E/D_E*F(3)-beta_E/D_E * (F(1)/T_p2)^(h*p_2)/(1+(F(1)/T_p2)^h)];
end

function [value, isterminal, direction] = my_event_fcn(t, y, x, b, a) 
t_limit = 100; % set a time limit (in seconds) 
value1 = t_limit - toc(start_time); 
value2 = min(y); 
value = min([value1, value2]); 
isterminal = 1; 
direction = 0; 
end 

end