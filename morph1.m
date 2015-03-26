function [FailResult,ndata]= morph2(FilePath,NumUp,NumDown)
 clc;clear;close all;
%%
NumDown=1;
NumUp=2;
NumDown=double(NumDown);
NumUp=double(NumUp);
FilePath='F:\xyc\St_Louis_Metro_LCMS_1mm\LCMS\';
%FilePath='H:\LCM\';
%FilePath='K:\data\St Louis Cross County Laser\CrossCounty_EastBound\Set04\';
%FilePath='K:\data\St Louis Scott Air Force Base Laser\WestBound\Set02\';
[dataL2,dataR2]=loadSections(FilePath,'INTDATA',NumDown,NumUp);%用了recified的图像，外部的螺栓看不清了
[dataL,dataR]=loadSections(FilePath,'RNGDATA',NumDown,NumUp);


%%
dataL1=dataL2(:,1:1020);
dataR = fliplr(dataR2);   %将矩阵dataR左右翻转
dataR1=dataR(:,1021:2040);
data=[dataL1,dataR1];
%data=[dataL1(2001:8000,:),dataR1(2186:8185,:)];%为了取得完整的三幅图片，先取出5幅图片，错位185行，这样可以补回左边比右边高出的那185行。

%%
ndata=select(data); %对于独特的水泥地基的铁路，利用距离的不同从rangedata中取出螺栓
imwrite(ndata,'c:\ndata.jpg');
%%
s = regionprops(ndata,'BoundingBox','Area','centroid');
Area = cat(1, s.Area);%所有连通区域的面积

% %显示原始图像
% imshow(ndata)
% hold on
% for i = 1:size(s,1)
%     rectangle('position',s(i).BoundingBox,'edgecolor','r');%画矩形框
%     r = s(i).Centroid;
%     text(r(1),r(2),num2str(i),'FontSize',5,'color',[1 0 0])%标记序号
% end
% hold off
%%
FailResult=Judge(ndata); %判断是否有螺栓缺失
%%
 %imagesc(data);
%data=dataL(:,200:340);
% 先膨胀，再腐蚀，开操作，
% 除掉小于结构元w的亮点细节，同时保留所有的灰度，并保证较大的亮区特征不收干扰
%w=[123,123];
%d1 = minfilt2(data,w);
%d2 = maxfilt2(d1,w);
%data(d2 <20)=0;
% 先腐蚀，再膨胀。闭操作，去掉比结构元小的黑暗细节。
%w=[63,63];
%d1 = minfilt2(data,w);%minfilt2  是局部最小算子， 也就是平的灰度腐蚀。
%d2 = maxfilt2(d1,w);%maxfilt2是局部最大算子，也就是平的灰度膨胀。maxfilt2 是使用的van Herk algorithm，速度很快，因为这种算的特殊，算的次数很少
%%
%d=data;
%d((data-d2) < 90)=0;
% figure;




%% 这一段的用意在于fastener的另外半边经常检测不到，但是右半边很明显，其实我觉得只要有半边在，那么整个fastner也就一定在了，这样做可以排除很多的干扰。
%d3=d;
%d3(:,240:340)=0;
%d3(:,1690:1760)=0;
%d=d-d3;
%save=d;
%% 

%% 去除和fastener 在同一行的一些噪声，这些噪声很小
%w=[5,5];
%d= maxfilt2(d,w);
%d = maxfilt2(d,w);
%% 膨胀fastener，方便数出联通的个数,因为fastener上面有缝隙。
%w=[173,173];
%d= maxfilt2(d,w);
%imwrite(save,'c:\1.jpg');
%% 数出个数


%I=d;

%I1 = ind2gray(I,colormap(gray)); 


%I2 = medfilt2(I1); 
%bw = im2bw(I2, graythresh(I2));

%[L, n]=bwlabel(bw, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n
%stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
%Cen = cat(1, stats.Centroid); % regionprops Centroid 为标记出这个region的property， centroid为型心的property

%%
%imagesc(d);
% plot(Cen(:, 1), Cen(:, 2), 'r+');
%str = sprintf('there is %d fastners', n);





