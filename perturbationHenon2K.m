% 有扰动的henon映射
function [K1, K2] = perturbationHenon2K(k, L)
    N0 = 100;
    x = zeros(L+N0,1);
    y = zeros(L+N0,1);    
    r = length(k);
    k = 0.0001*double(k)/255;
    c = 100*mean(k);
    u1 = 1.39+c;
    p1 = 0.3-20*c;   
    x(1) = 0.3 + c;
    y(1) = 0.4 - c;
    ri=1;
    for i = 1:L+N0-1
        x(i+1) = 1+y(i) - u1*x(i).^2 + k(ri);
        y(i+1) = p1*x(i);
        ri=ri+1;
        if(ri==r+1),ri=1;end        
    end 
    x = x(N0+1:end);
    y = y(N0+1:end);
    x = x*1e5-floor(x*1e5);
    y = y*1e5-floor(y*1e5);
    m1 = min(x);
    m2 = min(y);
    K1 = floor(255.9999*(x-m1)/(max(x)-m1));
    K2 = floor(255.9999*(y-m2)/(max(y)-m2));
end


