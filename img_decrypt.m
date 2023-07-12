% 解密流程
% img_path 待解密图像路径
% img      图像矩阵
% key      密钥
% kimg     解密后的图像
function kimg=img_decrypt(img_path,img,key)
% 第一步，将图像变成列向量img1d
    if isempty(img)
        img=imread(img_path);
    end
    img_size=size(img);
    M = img(:);
    L = length(M);
    
    % 第二步，密钥关联处理
    [u0,p0,x0,y0,k0]=deal(key(1),key(2),key(3),key(4),key(5:end));
    k = keyProcessing(u0,p0,x0,y0,k0(:));
    [P1, P2] = crossSampleToSeq(k,L);
    [K1, K2] = perturbationHenon2K(k, L); 
    
    % 第一次逆扩散
    for i = L:-1:2
        M(i) = bitxor(bitxor(M(i),M(i-1)),K2(i));
    end
    M(1) = bitxor(M(1),K2(1));

    % 第一次逆排列
    M(P2) = M;
    
    % 第二次逆扩散  
    M = double(M); 
    for i = L:-1:2        
        M(i) = mod(M(i)-M(i-1)-K1(i),256);        
    end
    M(1) = mod(M(1)-sum(M(2:end))-K1(1),256);
    
    % 第二次逆排列
    M = uint8(M);
    M(P1) = M;        
    
    % 重构图像
    kimg = reshape(M,img_size);
end