% 交叉取样置乱序列P1
% r 轮数
% w 偏移量
% L 序列长度 
% P1 用于置乱的下标序列
function [P1, P2] = crossSampleToSeq(k,L)
    % 分裂为两个序列    
    s1 = 1:floor(L/2);
    s2 = floor(L/2)+1:L;
    % 间隔2取样
    a1 = s1(1:3:end);
    a2 = s1(2:3:end);
    a3 = s1(3:3:end);  
    b1 = s2(1:3:end);
    b2 = s2(2:3:end);
    b3 = s2(3:3:end);
    % 块排列
    s = [b1,a1,b2,a2,b3,a3];
    % 间隔2取样
    s = [s(1:3:end),s(2:3:end),s(3:3:end)];
    % 间隔1取样
    P = [s(1:2:end),s(2:2:end)];    

    % 自排列
    P=P(P);  

    % w1 w2值    
    r = length(k); 
    k = double(k(:));    
    w1 = mod(100*(1:r)*k,L);
    w2 = mod(100*(r:-1:1)*k,L);
    P1 = circshift(P,-w1);
    P2 = circshift(P,-w2);
end