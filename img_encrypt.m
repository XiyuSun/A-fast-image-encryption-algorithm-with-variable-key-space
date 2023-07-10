% 加密流程
% img_path 待加密图像路径
% img      图像矩阵
% key      密钥
% simg     密文图像矩阵
% skey     解密密钥
function [simg,skey]=img_encrypt(img_path,img,key)
    skey = key;
    tic
    % 第一步，将图像变成列向量img1d
    if isempty(img)
        img=imread(img_path);
    end
    img_size=size(img);
    M = double(img(:));
    L = length(M);
    toc    
    % 第二步，密钥关联处理
    [u0,p0,x0,y0,k0]=deal(key(1),key(2),key(3),key(4),key(5:end));   
    tic
    k = keyProcessing(u0,p0,x0,y0,k0(:));   
    toc
    tic
    [P1, P2] = crossSampleToSeq(k,L);    
    toc
    tic
    [K1, K2] = perturbationHenon2K(k, L);   
    toc
    % 第一次排列  
    tic
    M = M(P1);
    toc
    tic
    % 第一次扩散
    M(1) = mod(sum(M)+K1(1),256);
    for i = 2:L      
        M(i) = mod(M(i-1)+M(i)+K1(i),256);
    end   
    toc
    tic
    % 第二次排列
    M = M(P2);   
    toc
    tic
    % 第二次扩散    
    M = uint8(M);
    K2 = uint8(K2);
    M(1) = bitxor(M(1),K2(1));
    for i = 2:L
        M(i) = bitxor(bitxor(M(i),M(i-1)),K2(i));
    end    
    toc
    % 重构图像
    simg = reshape(M,img_size);
end




