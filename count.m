
I=d;
figure;
subplot(2, 2, 1); imshow(I);
title('ԭͼ');
I1 = rgb2gray(I); 
subplot(2, 2, 2); imshow(I1);
title('�Ҷ�ͼ');
I2 = medfilt2(I1); 
bw = im2bw(I2, graythresh(I2));
subplot(2, 2, 3); imshow(bw);
title('��ֵͼ');
[L, n]=bwlabel(bw, 4); %�������������㶹����n
subplot(2, 2, 4); imshow(I);
stats = regionprops(L);
Cen = cat(1, stats.Centroid);
hold on;
plot(Cen(:, 1), Cen(:, 2), 'r+');
str = sprintf('��%d������', n);
title(str, 'Color', 'r');
