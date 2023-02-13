function [x, fun_val] = gradient_method_quadratic(A, b, x0, epsilon)
%
% input: A ------- coefficient matrix associated with quadratic part
%        b ------- column vector associated with linear part 
%        x0 ------ initial guess
%        epsilon - tolerance 
%
% output: x ------- an optimal solution to x'Ax + 2b'x (up to a tolerance) 
%         fun_val - the optimal function value up to a tolerance

x = x0(:);
iter = 0;
grad = 2*(A*x + b);
while (norm(grad) > epsilon)
    iter = iter + 1;
    t = norm(grad)^2 / (2*grad'*A*grad);
    x = x - t*grad;
    grad = 2*(A*x + b);
    fun_val = x'*A*x + 2*b'*x;
    fprintf('iter_number = %3d norm_grad = %2.6f fun_val = %2.6f \n', iter, norm(grad), fun_val);
end
