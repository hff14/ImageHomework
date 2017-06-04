function image_processed = Affinetrans_Bilinearity(image, theta, tx, ty, sx, sy)
% image为图像的RGB矩阵
% theta为旋转角度 顺时针为正 单位为度
% tx和ty分别为纵向平移和横向平移的像素数 向下和向右为正方向
% sx和sy分别为纵向放缩和横向放缩的倍数 向下和向右为拉伸方向

nrow = size(image,1);
ncolumn = size(image,2);
ncolor = size(image,3);

backrow = 4 * nrow;
backcolumn = 4 * ncolumn;

imageback = zeros(backrow+1, backcolumn+1, ncolor);
tempback = zeros(backrow+1, backcolumn+1, ncolor);
imageback(2*nrow+1:3*nrow,2*ncolumn+1:3*ncolumn, :) = image;

R = [cos(pi*(theta/180)),sin(pi*(theta/180)),0;-sin(pi*(theta/180)),cos(pi*(theta/180)),0;0,0,1]; 
Rinv = [cos(pi*(-theta/180)),sin(pi*(-theta/180)),0;-sin(pi*(-theta/180)),cos(pi*(-theta/180)),0;0,0,1];
if theta~=0
    for m = -2*nrow:2*nrow
        for n = -2*ncolumn:2*ncolumn
            tempv = [m;n;1];
            temp = Rinv * tempv;
            if(temp(1)>=(-2*nrow)&&temp(1)<=(2*nrow)&&temp(2)>=(-2*ncolumn)&&temp(2)<=(2*ncolumn))
                gE = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:);
                gF = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:);
                tempback(m+2*nrow+1,n+2*ncolumn+1,:) = (temp(2)-floor(temp(2)))*(gF-gE)+gE;
            end
        end
    end
    imageback = tempback;
    tempback = zeros(backrow+1, backcolumn+1, ncolor);
end



S = [sx,0,0;0,sy,0;0,0,1];
Sinv = [1/sx,0,0;0,1/sy,0;0,0,1];
if sx~=1 || sy~=1
    for m = -2*nrow:2*nrow
        for n = -2*ncolumn:2*ncolumn
            tempv = [m;n;1];
            temp = Sinv * tempv;
            if(temp(1)>=(-2*nrow)&&temp(1)<=(2*nrow)&&temp(2)>=(-2*ncolumn)&&temp(2)<=(2*ncolumn))
                gE = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:);
                gF = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:);
                tempback(m+2*nrow+1,n+2*ncolumn+1,:) = (temp(2)-floor(temp(2)))*(gF-gE)+gE;
            end
        end
    end
    imageback = tempback;
    tempback = zeros(backrow+1, backcolumn+1, ncolor);
end

T = [1,0,tx;0,1,ty;0,0,1];
Tinv = [1,0,-tx;0,1,-ty;0,0,1];
if tx~=0 || ty~=0
    for m = -2*nrow:2*nrow
        for n = -2*ncolumn:2*ncolumn
            tempv = [m;n;1];
            temp = Tinv * tempv;
            if(temp(1)>=(-2*nrow)&&temp(1)<=(2*nrow)&&temp(2)>=(-2*ncolumn)&&temp(2)<=(2*ncolumn))
                gE = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,floor(temp(2))+2*ncolumn+1,:);
                gF = (temp(1)-floor(temp(1)))*(imageback(ceil(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:)-imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:))+imageback(floor(temp(1))+2*nrow+1,ceil(temp(2))+2*ncolumn+1,:);
                tempback(m+2*nrow+1,n+2*ncolumn+1,:) = (temp(2)-floor(temp(2)))*(gF-gE)+gE;
            end
        end
    end
    imageback = tempback;
    tempback = zeros(backrow+1, backcolumn+1, ncolor);
end

image_processed = imageback;

end
