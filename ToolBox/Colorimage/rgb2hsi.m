function image_hsi = rgb2hsi(image)
% rgb图像转hsi图像
% h,s,i均在0到1区间取值
% r,g,b均在0到255区间取值

% 先做归一化
image = im2double(uint8(image));
image_r = image(:, :, 1);  
image_g = image(:, :, 2);  
image_b = image(:, :, 3);

image_i = (image_r+image_g+image_b)/3;
image_s = 1 - 3.*min(min(image_r, image_g), image_b)./(image_r+image_g+image_b+eps);
image_h = acos((0.5*((image_r-image_g)+(image_r-image_b)))./(sqrt((image_r-image_g).^2+(image_r-image_b).*(image_g-image_b))+eps));
image_h(image_b > image_g) = 2*pi - image_h(image_b > image_g);
image_h = image_h/(2*pi);
image_h(image_s == 0) = 0;

image_hsi = cat(3,image_h,image_s,image_i);

end


