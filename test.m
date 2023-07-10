
key = [1.39,0.29,0.2,0.3,1:8];
imgPath = 'Lena.tiff';

img = imread(imgPath);
img = rgb2gray(img);
img = imresize(img,[1024,1024]);
% tic
[simg,skey] = img_encrypt([],img,key);
% toc
% tic
kimg = img_decrypt([],simg,key);
% toc

figure('Name','原图--密文图像--解密后的图像');
subplot(131);
imshow(img);
subplot(132);
imshow(uint8(simg));
subplot(133);
imshow(uint8(kimg));

