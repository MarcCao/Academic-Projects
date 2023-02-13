function [x,fun_val] = gradient_method_backtracking(f, g, x0, s, alpha, beta, epsilon)
%
% input: A -------- coefficient matrix associated with quadratic part
%        b -------- column vector associated with linear part 
%        x0 ------- initial guess
%        s -------- initial stepsize in line search
%        alpha ---- tolerance parameter for backtrack line search
%        beta ----- the proportion in which the stepsize is multiplied at each backtracking step
%        epsilon -- tolerance 
%
% output: x ------- an optimal solution (up to a tolerance) associated with x'*A*x + 2*b'*x
%         fun_val - the optimal function value up to a tolerance

x = x0(:);
grad = g(x);
fun_val = f(x);
iter = 0;
while (norm(grad) > epsilon)
    iter = iter + 1;
    t = s;
    while (fun_val - f(x - t*grad) < alpha*t*norm(grad)^2)
        t = beta*t;
    end
    x = x - t*grad;
    fun_val = f(x);
    grad = g(x);
    fprintf('iter_number = %3d norm_grad = %2.6f fun_val = %2.6f \n', iter, norm(grad), fun_val);
end
