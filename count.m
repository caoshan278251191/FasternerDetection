
I=d;
figure;
subplot(2, 2, 1); imshow(I);
title('原图');
I1 = rgb2gray(I); 
subplot(2, 2, 2); imshow(I1);
title('灰度图');
I2 = medfilt2(I1); 
bw = im2bw(I2, graythresh(I2));
subplot(2, 2, 3); imshow(bw);
title('二值图');
[L, n]=bwlabel(bw, 4); %计算测量面积内豌豆个数n
subplot(2, 2, 4); imshow(I);
stats = regionprops(L);
Cen = cat(1, stats.Centroid);
hold on;
plot(Cen(:, 1), Cen(:, 2), 'r+');
str = sprintf('共%d个种子', n);
title(str, 'Color', 'r');
