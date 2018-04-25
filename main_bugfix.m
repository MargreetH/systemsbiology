%%%%%% Variables
clear all; close all; clc;

spacing = 2; %Amount of spacing for each vector.

D_M = logspace(-1,1,spacing); %1
D_E = logspace(-1,1,spacing);
alpha_1 = logspace(-5,0,spacing);
alpha_2 = logspace(-3,2,spacing);
alpha_E = logspace(-5,0,spacing);
nu = logspace(-1,1,spacing);
beta_E = logspace(-4,-2,spacing);
p_1 = [-1 1];
p_2 = [0 1];
T_0 = logspace(-5,3,spacing);
T_1 = logspace(-1,1,spacing);
h = 2:(3-2)/spacing:3;
L = [100 200];
maxTime = 5*10^5;


% X and t scale
xsteps = 10;
tsteps = 20;



x1 = [0 100];


[solx,soly] = solveSystemPDEs(D_M(2), p_1(1), alpha_1(1), alpha_2(1), D_E(1), alpha_E(1), beta_E(1), T_0(1) ,h(1),p_2(1), nu(1), x1);







figure;
hold on;
plot(solx, soly(:,1));
%plot(solx, soly(:,2));
%plot(solx, soly(:,3));
%plot(solx, soly(:,4));
%legend('y_1','y_2', 'y_3', 'y_4')
hold off;






%%%%%%