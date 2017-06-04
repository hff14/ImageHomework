clear all, close all, clc;

image = imread('Lena_color.bmp');

%% 将rgb图片转为hsi图片并绘制其单通道图像
image_hsi = rgb2hsi(image);
for m = 1:3
    figure(2*m-1);
    imshow(image(:,:,m));
    % title(2*m-1);
    figure(2*m);
    imshow(image_hsi(:,:,m));
    % title(2*m);
end

%% 对转换得到的I通道图像做伪彩色处理
image_i = image_hsi(:,:,3);
imagetemp_r = zeros(size(image,1),size(image,2));
imagetemp_g = zeros(size(image,1),size(image,2));
imagetemp_b = zeros(size(image,1),size(image,2));

for i = 1:size(image_i,1)
    for j = 1:size(image_i,2)
        if image_i(i,j)>=0 && image_i(i,j)<0.25
            imagetemp_g(i,j) = 1023*image_i(i,j);
            imagetemp_b(i,j) = 255;
        end
        if image_i(i,j)>=0.25 && image_i(i,j)<0.5
            imagetemp_g(i,j) = 255;
            imagetemp_b(i,j) = 511-1023*image_i(i,j);
        end
        if image_i(i,j)>=0.5 && image_i(i,j)<0.75
            imagetemp_r(i,j) = 1023*image_i(i,j)-511;
            imagetemp_g(i,j) = 255;
        end
        if image_i(i,j)>=0.75 && image_i(i,j)<=1
            imagetemp_r(i,j) = 255;
            imagetemp_g(i,j) = 1023-1023*image_i(i,j);
        end
    end
end

image2 = cat(3,imagetemp_r, imagetemp_g, imagetemp_b);
image2 = uint8(image2);

figure;
imshow(image2);
% title(7);

%% 对原始图像的S通道图像进行饱和度增强
a = 1.2;
image_hsi(:,:,2) = image_hsi(:,:,2) * a;
image3 = hsi2rgb(image_hsi);
image3 = image3 * 256 - 1;
figure;
imshow(image);
% title(8);
figure;
imshow(uint8(image3));
% title(9);



