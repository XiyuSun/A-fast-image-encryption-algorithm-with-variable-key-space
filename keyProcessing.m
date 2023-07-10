% 密钥处理
function k = keyProcessing(u0,p0,x0,y0,k0)
    N0 = 100;
    L = length(k0);
    x = zeros(L+N0,1);
    y = zeros(L+N0,1);
    x(1) = x0;
    y(1) = y0;
    for i = 1:L+N0-1
        x(i+1) = 1+y(i) - u0*x(i).^2;
        y(i+1) = p0*x(i);
    end 
    x = mod(floor(x(N0+1:end)*1e10),256);   
    k = bitxor(uint8(k0), uint8(x));
end



