function [x, fval] = hybrid_newton(f, g, h, x0, alpha, beta, s, epsilon)
%
% input: f ------- objective function
%        g ------- gradient of the objective function
%        h ------- hessian of the objective function
%        x0 ------ initial guess
%        alpha ---- tolerance parameter for backtrack line search
%        beta ----- the proportion in which the stepsize is multiplied at each backtracking step
%        epsilon -- tolerance 
%
% output: x ------- an optimal solution (up to a tolerance)
%         fun_val - the optimal function value up to a tolerance

x = x0(:);
gval = g(x);
hval = h(x); 

% compute the search direction
[m, ~] = size(hval);
l = zeros(m,m);
flag = 0;
for i = 1:m
    if (hval(i,i) <= 0)
        flag = 1;
        break
    else
        l(i,i) = sqrt(hval(i,i));
        for k = i+1:m
            l(k,i) = hval(k,i)/sqrt(hval(i,i));
        end
        if (i < m)
            hval(i+1:end,i+1:end) = hval(i+1:end,i+1:end) - (1/hval(i,i))*hval(i+1:end,i)*hval(i+1:end,i)';
        end
    end
end

if (flag == 0)
    d = l'\(l\gval);
else
    d = gval;
end

iter = 0;
while ( (norm(gval) > epsilon) && (iter<10000) )
    iter = iter + 1;
    t = s; 
    while(f(x-t*d) > f(x)-alpha*t*gval'*d)
        t = beta*t;
    end
    x = x - t*d;
    fval = f(x);
    fprintf('iter= %2d f(x)=%10.10f\n', iter, fval) 
    gval = g(x);
    hval = h(x);
    
    % compute the search direction
    [m, ~] = size(hval);
    l = zeros(m,m);
    flag = 0;
    for i = 1:m
        if (hval(i,i) <= 0)
           flag = 1;
           break
        else
           l(i,i) = sqrt(hval(i,i));
           for k = i+1:m
               l(k,i) = hval(k,i)/sqrt(hval(i,i));
           end
           if (i < m)
               hval(i+1:end,i+1:end) = hval(i+1:end,i+1:end) - (1/hval(i,i))*hval(i+1:end,i)*hval(i+1:end,i)';
           end
        end
    end
    if (flag == 0)
       d = l'\(l\gval);
    else
       d = gval;
    end
    
end

if (iter == 10000)
    fprintf('did not converge\n')
end