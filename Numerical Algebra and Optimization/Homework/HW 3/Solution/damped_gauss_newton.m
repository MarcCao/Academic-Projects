function [x, fval] = damped_gauss_newton(f, g, J, F, x0, s, alpha, beta, epsilon)
%
% input: f ------------- objective function f = sum_i (li(x) - ci)^2
%        g ------------- gradient of the objective function
%        J ------------- Jacobian matrix (... ; (nabla li)' ; ...)
%        F ------------- F = (... ; li(x) - ci; ...)
%        x0 ------------ initial guess
%        s ------------- initial stepsize in line search
%        alpha --------- tolerance parameter for backtrack line search
%        beta ---------- the proportion in which the stepsize is multiplied at each backtracking step
%        epsilon ------- tolerance 
%
% output: x ------- an optimal solution (up to a tolerance) 
%         fun_val - the optimal function value up to a tolerance


x = x0;
grad = g(x);
d = (J(x)'*J(x))\(J(x)'*F(x));

iter = 0;
while ((norm(grad) > epsilon) && (iter < 10000))
    iter = iter + 1;
    t = s;
    while (f(x) - f(x - t*d) < alpha*t*grad'*d)
        t = beta*t;
    end
   
    x = x - t*d;
    fval = f(x);
    grad = g(x);
    d = (J(x)'*J(x))\(J(x)'*F(x));
    
    fprintf('iter = %2d f(x) = %10.10f\n', iter, fval)
end
if (iter == 10000)
    fprintf('the damped Gauss Newton method did not converge')
end
