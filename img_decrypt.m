% ��������
% img_path ������ͼ��·��
% img      ͼ�����
% key      ��Կ
% kimg     ���ܺ��ͼ��
function kimg=img_decrypt(img_path,img,key)
% ��һ������ͼ����������img1d
    if isempty(img)
        img=imread(img_path);
    end
    img_size=size(img);
    M = img(:);
    L = length(M);
    
    % �ڶ�������Կ��������
    [u0,p0,x0,y0,k0]=deal(key(1),key(2),key(3),key(4),key(5:end));
    k = keyProcessing(u0,p0,x0,y0,k0(:));
    [P1, P2] = crossSampleToSeq(k,L);
    [K1, K2] = perturbationHenon2K(k, L); 
    
    % ��һ������ɢ
    for i = L:-1:2
        M(i) = bitxor(bitxor(M(i),M(i-1)),K2(i));
    end
    M(1) = bitxor(M(1),K2(1));

    % ��һ��������
    M(P2) = M;
    
    % �ڶ�������ɢ  
    M = double(M); 
    for i = L:-1:2        
        M(i) = mod(M(i)-M(i-1)-K1(i),256);        
    end
    M(1) = mod(M(1)-sum(M(2:end))-K1(1),256);
    
    % �ڶ���������
    M = uint8(M);
    M(P1) = M;        
    
    % �ع�ͼ��
    kimg = reshape(M,img_size);
end