function [x, fun_val] = scaled_gradient_method_backtracking(A, b, D, x0, s, alpha, beta, epsilon)
%
% input: A -------- coefficient matrix associated with quadratic part
%        b -------- column vector associated with linear part 
%        D -------- scaling matrix
%        x0 ------- initial guess
%        s -------- initial stepsize in line search
%        alpha ---- tolerance parameter for backtrack line search
%        beta ----- the proportion in which the stepsize is multiplied at each backtracking step
%        epsilon -- tolerance 
%
% output: x ------- an optimal solution (up to a tolerance) associated with x'*A*x + 2*b'*x
%         fun_val - the optimal function value up to a tolerance

x = x0(:);
f = @(x) x'*A*x + 2*b'*x;
grad = 2*(A*x + b);

iter = 0;
while (norm(grad) > epsilon)
    iter = iter + 1;
    t = s;
    while (f(x) - f(x - t*(D*grad)) < alpha*t*grad'*(D*grad))
        t = beta*t;
    end
    x = x - t*(D*grad);
    grad = 2*(A*x + b);
    fun_val = f(x);
    fprintf('iter_number = %3d norm_grad = %2.6f fun_val = %2.6f \n', iter, norm(grad), fun_val);
end