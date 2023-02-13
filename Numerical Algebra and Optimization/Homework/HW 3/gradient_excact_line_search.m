function [x, iter, fun_val] = gradient_excact_line_search(A, f, g, x0, epsilon)
    x = x0; 
    grad = g(x); 
    iter = 0; 
    fun_val = f(x0); 
    dk = -grad; 
    while (norm(grad) > epsilon)
        iter = iter + 1; 
        t = ((dk)'*dk)/(2*(dk)'*A*dk);
        x = x - t*grad; 
        fun_val = f(x); 
        grad = g(x); 
    end