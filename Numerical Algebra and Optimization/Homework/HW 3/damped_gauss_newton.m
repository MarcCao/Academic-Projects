function [x, iter, fun_val] = damped_gauss_newton(f, g, h, x0, s, a, b, epsilon)
    x = x0; 
    grad = g(x); 
    hess = h(x); 
    L = chol(hess, 'lower'); 
    u = inv(L) * grad; 
    d = inv(trans(L))*u; 
    %d = hess(x) \ g(x); 
    iter = 0; 
    fun_val = f(x0); 
    while (norm(grad) > epsilon)
        iter = iter + 1; 
        t = s; 
        L = chol(hess, 'lower'); 
        u = inv(L) * grad; 
        d = inv(trans(L))*u; 
        while(f(x-t*d) > f(x) - a*t*(d)'*d)
            t = t*b; 
        end
        x = x - t*d; 
        fun_val = f(x); 
        grad = g(x); 
        hess = h(x); 
        L = chol(hess, 'lower'); 
        u = inv(L) * grad; 
        d = inv(trans(L))*u; 
    end
