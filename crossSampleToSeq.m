% 交叉取样置乱序列P1
% r 轮数
% w 偏移量
% L 序列长度 
% P1 用于置乱的下标序列
function [P1, P2] = crossSampleToSeq(k,L)
    % 分裂为两个序列    
    s1 = uint32(1:floor(L/2));
    s2 = uint32(floor(L/2)+1:L);
    
    % 间隔2取样
    a1 = s1(1:3:end); 
    a2 = s1(2:3:end);
    a3 = s1(3:3:end);  
    b1 = s2(1:3:end);
    b2 = s2(2:3:end);
    b3 = s2(3:3:end);
    la1 = length(a1);
    la2 = length(a2);
    la3 = length(a3);
    lb1 = length(b1);
    lb2 = length(b2);
    lb3 = length(b3);
    
    % 块排列
    s = zeros(1,L,'uint32');
    st = 1;
    ed = lb1;
    s(st:ed) = b1;

    st = ed + 1; 
    ed = ed + la1;
    s(st:ed) = a1;

    st = ed + 1; 
    ed = ed + lb2;
    s(st:ed) = b2;

    st = ed + 1; 
    ed = ed + la2;
    s(st:ed) = a2;

    st = ed + 1; 
    ed = ed + lb3;
    s(st:ed) = b3;

    st = ed + 1; 
    ed = ed + la3;
    s(st:ed) = a3;

    % 间隔2取样
    a1 = s(1:3:end);
    a2 = s(2:3:end);
    a3 = s(3:3:end);
    la1 = length(a1);
    la2 = length(a2);
    la3 = length(a3);
    
    st = 1;
    ed = la1;
    s(st:ed) = a1;

    st = ed + 1; 
    ed = ed + la2;
    s(st:ed) = a2;

    st = ed + 1; 
    ed = ed + la3;
    s(st:ed) = a3;

    % 间隔1取样
    a1 = s(1:2:end);
    a2 = s(2:2:end);
    la1 = length(a1);
    la2 = length(a2);

    st = 1;
    ed = la1;
    s(st:ed) = a1;

    st = ed + 1; 
    ed = ed + la2;
    s(st:ed) = a2;

    % 自排列
    P=s(s);  

    % w1 w2值    
    r = length(k); 
    k = double(k(:));    
    w1 = mod(100*(1:r)*k,L);
    w2 = mod(100*(r:-1:1)*k,L);
    P1 = circshift(P,-w1);
    P2 = circshift(P,-w2);
end
