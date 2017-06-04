clear all, close all, clc;

image = imread('Lena_color.bmp');

%% �ֱ�ʹ������ڲ�ֵ��˫���Բ�ֵ��ͼ����з���任
image_processed_Nearest = Affinetrans_Nearest(image, 0, 0, 0, 1.5, 1.5);
image_processed_Bilinearity = Affinetrans_Bilinearity(image, 0, 0, 0, 1.5, 1.5);

figure;
imshow(uint8(image_processed_Nearest));
figure;
imshow(uint8(image_processed_Bilinearity));