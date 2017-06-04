function image = hsi2rgb(image_hsi)
% hsi图像转rgb图像
% h,s,i均在0到1区间取值
% r,g,b均在0到1区间取值

image_h = image_hsi(:,:,1)*2*pi;
image_s = image_hsi(:,:,2);
image_i = image_hsi(:,:,3);

image_r=zeros(size(image_hsi,1),size(image_hsi,2));
image_g=zeros(size(image_hsi,1),size(image_hsi,2));
image_b=zeros(size(image_hsi,1),size(image_hsi,2));

d=find((0<=image_h)& (image_h<2*pi/3));
image_b(d)=image_i(d).*(1-image_s(d));
image_r(d)=image_i(d).*(1+image_s(d).*cos(image_h(d))./cos(pi/3-image_h(d)));
image_g(d)=3*image_i(d)-(image_r(d)+image_b(d));


d=find((2*pi/3<=image_h)& (image_h<4*pi/3));
image_r(d)=image_i(d).*(1-image_s(d));
image_g(d)=image_i(d).*(1+image_s(d).*cos(image_h(d)-2*pi/3)./cos(pi-image_h(d)));
image_b(d)=3*image_i(d)-(image_r(d)+image_g(d));

d=find((4*pi/3<=image_h)& (image_h<2*pi));
image_g(d)=image_i(d).*(1-image_s(d));
image_b(d)=image_i(d).*(1+image_s(d).*cos(image_h(d)-4*pi/3)./cos(5*pi/3-image_h(d)));
image_r(d)=3*image_i(d)-(image_g(d)+image_b(d));

image=cat(3,image_r,image_g,image_b);
image=max(min(image,1),0);

end
