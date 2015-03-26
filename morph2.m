function [d]= morph2(FilePath)
FilePath='E:\LCM\';
[dataL,dataR]=loadSections(FilePath,1:3,'RectifiedRngIm');
%%
dataL1=dataL(:,1:1020);
dataR = fliplr(dataR);   %将矩阵dataR左右翻转
dataR1=dataR(:,1021:2040);
data=[dataL1,dataR1];
data1=data;
%%
 %imagesc(data);
%data=data(:,140:500);
% 先膨胀，再腐蚀，开操作，
% 除掉小于结构元w的亮点细节，同时保留所有的灰度，并保证较大的亮区特征不收干扰
w=[123,123];
d1 = minfilt2(data,w);
d2 = maxfilt2(d1,w);
%%
data(d2 <20)=0;
%% 先腐蚀，再膨胀。闭操作，去掉比结构元小的黑暗细节。
w=[63,63];
d1 = minfilt2(data,w);%minfilt2  是局部最小算子， 也就是平的灰度腐蚀。
d2 = maxfilt2(d1,w);%maxfilt2是局部最大算子，也就是平的灰度膨胀。maxfilt2 是使用的van Herk algorithm，速度很快，因为这种算的特殊，算的次数很少
%%
d=data;
d(data-d2 < 55)=0;
% figure;
%imagesc(d);
%figure('Name','Fastner Outcome');
%subplot(1,2,1);
%imagesc(data1, [0 255]); axis normal;
%subplot(1,2,2);
%imagesc(d , [0 255]); axis normal;
end


%Mathematical morphology 
