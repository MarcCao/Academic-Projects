function [x, iter, fun_val] = gradient_backtracking(f, g, x0, s, a, b, epsilon)
    x = x0; 
    grad = g(x); 
    iter = 0; 
    fun_val = f(x0); 
    while (norm(grad) > epsilon)
        iter = iter + 1; 
        t = s; 
        while(f(x-t*grad) > f(x) - a*t*(grad)'*grad)
            t = t*b; 
        end
        x = x - t*grad; 
        fun_val = f(x); 
        grad = g(x); 
    end
