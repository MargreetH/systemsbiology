%Solves the two PDE's for a set of values.
function sol = solvePDEs(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T_p2, h ,p_2, nu, xx, t)

m = 0;

%Stuff to quit trying to solve the DE when finding the solution takes too
%long
options = odeset('Events', @my_event_fcn); 
start_time = tic; 

sol = pdepe(m,@pdex4pde0,@pdex4ic,@pdex4bc, xx, t, options);


%Encodes the 2 PDE's into MATLAB
function [c,f,s] = pdex4pde0(x,t,u,DuDx)
c = [1; 1]; 
f = [D_M; D_E] .* DuDx; 
s = [-(1+u(1))^p_1*alpha_1*u(2)-(1+u(1))^alpha_2*u(2)^2 ; -alpha_E*u(1)+beta_E * (u(2)/T_p2)^(h*p_2) * (1+(u(2)/T_p2)^h)^(-1)]; 
end

%Encode initial condition ??? what does it need to be. I'd say 0 for M, and
%soemthing for E???
function u0 = pdex4ic(x)
u0 = [0; 0]; 
end

%Encode boundary conditions
function [pl,ql,pr,qr] = pdex4bc(xl,ul,xr,ur,t)
pl = [nu; 0]; 
ql = [1; 1];     
pr = [0; 0]; 
qr = [1; 1];
end

function [value, isterminal, direction] = my_event_fcn(t, y, x, b, a) 
t_limit = 5; % set a time limit (in seconds) 
value1 = t_limit - toc(start_time); 
value2 = min(y); 
value = min([value1, value2]); 
isterminal = 1; 
direction = 0; 
end 

end