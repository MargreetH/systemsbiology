function y = createParamVector(D_M, p_1, alpha_1, alpha_2, D_E, alpha_E, beta_E, T ,h, p, metric)
 y = zeros(1,11);
 y(1) = D_M;
 y(2) = p_1;
 y(3) = alpha_1;
 y(4) = alpha_2;
 y(5) = D_E;
 y(6) = alpha_E;
 y(7) = beta_E;
 y(8) = T;
 y(9) = h;
 y(10) = p;
 y(11) = metric;

end