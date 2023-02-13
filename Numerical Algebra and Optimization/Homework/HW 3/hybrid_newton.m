function [x, iter, fun_val] = hybrid_newton(f, g, h, x0, s, a, b, epsilon)
    x = x0; 
    grad = g(x); 
    hess = h(x); 
    d = h(x) \ g(x); 
    iter = 0; 
    fun_val = f(x0); 
    while (norm(grad) > epsilon)
        iter = iter+1; 
        e = eig(h(x)); 
        if (e(1) <= 0) || (e(2) <= 0)
            d = -grad; 
        else
            d = h(x)\(-grad); 
        end
        t = s; 
        while(f(x-t*grad) > f(x) - a*t*(grad)'*grad)
            t = b*t; 
        end
        x = x+t*d; 
        fun_val = f(x); 
        grad = g(x); 
    end
    x = x+t*d;
    fun_val = f(x); 
    grad = g(x); 
