% ��������
% img_path ������ͼ��·��
% img      ͼ�����
% key      ��Կ
% simg     ����ͼ�����
% skey     ������Կ
function [simg,skey]=img_encrypt(img_path,img,key)
    skey = key;
    tic
    % ��һ������ͼ����������img1d
    if isempty(img)
        img=imread(img_path);
    end
    img_size=size(img);
    M = double(img(:));
    L = length(M);
    toc    
    % �ڶ�������Կ��������
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
    % ��һ������  
    tic
    M = M(P1);
    toc
    tic
    % ��һ����ɢ
    M(1) = mod(sum(M)+K1(1),256);
    for i = 2:L      
        M(i) = mod(M(i-1)+M(i)+K1(i),256);
    end   
    toc
    tic
    % �ڶ�������
    M = M(P2);   
    toc
    tic
    % �ڶ�����ɢ    
    M = uint8(M);
    K2 = uint8(K2);
    M(1) = bitxor(M(1),K2(1));
    for i = 2:L
        M(i) = bitxor(bitxor(M(i),M(i-1)),K2(i));
    end    
    toc
    % �ع�ͼ��
    simg = reshape(M,img_size);
end




