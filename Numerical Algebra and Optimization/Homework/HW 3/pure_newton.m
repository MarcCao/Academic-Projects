function x = pure_newton(f,g,h,x0,epsilon,itmax)

% f ------------- objective function
% g ------------- gradient of the objective function
% h ------------- Hessian of the objective function
% x0 ------------ initial guess
% epsilon ------- tolerance
% itmax --------- maximum number of iterations

% x ------------- solution find by pure Newton's method

x = x0;
g_value = g(x);
h_value = h(x);

iter = 0;
while ((norm(g_value) > epsilon) && (iter < itmax))
    iter = iter + 1;
    x = x - h_value\g_value;
    g_value = g(x);
    h_value = h(x);
    
    fprintf('iter = %2d f(x) = %10.10f\n', iter, f(x))
end
if (iter == itmax)
    fprintf('the pure Newton method did not converge')
end
