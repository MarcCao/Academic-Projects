function [fval, x] = gradient_projection(f, g, x0, t)

% input: 
%     f: objective function
%     g: gradient of the objective function
%    x0: initial guess
%     t: constant step size

x = x0(:);

for iter = 1:100
    
    xtemp = x - t*g(x);
    x = xtemp;
    x(xtemp < 0) = x(xtemp < 0)*0;
    
    fprintf('iter = %2d, x = [', iter)
    fprintf('%11.4e,', x(1:end-1))
    fprintf('%11.4e], ', x(end))
    fprintf('fun_val = %2.6f \n', f(x))
    
end

fval = f(x);
    
