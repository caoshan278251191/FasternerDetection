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
[dataL2,dataR2]=loadSections(FilePath,'INTDATA',NumDown,NumUp);%����recified��ͼ���ⲿ����˨��������
[dataL,dataR]=loadSections(FilePath,'RNGDATA',NumDown,NumUp);


%%
dataL1=dataL2(:,1:1020);
dataR = fliplr(dataR2);   %������dataR���ҷ�ת
dataR1=dataR(:,1021:2040);
data=[dataL1,dataR1];
%data=[dataL1(2001:8000,:),dataR1(2186:8185,:)];%Ϊ��ȡ������������ͼƬ����ȡ��5��ͼƬ����λ185�У��������Բ�����߱��ұ߸߳�����185�С�

%%
ndata=select(data); %���ڶ��ص�ˮ��ػ�����·�����þ���Ĳ�ͬ��rangedata��ȡ����˨
imwrite(ndata,'c:\ndata.jpg');
%%
s = regionprops(ndata,'BoundingBox','Area','centroid');
Area = cat(1, s.Area);%������ͨ��������

% %��ʾԭʼͼ��
% imshow(ndata)
% hold on
% for i = 1:size(s,1)
%     rectangle('position',s(i).BoundingBox,'edgecolor','r');%�����ο�
%     r = s(i).Centroid;
%     text(r(1),r(2),num2str(i),'FontSize',5,'color',[1 0 0])%������
% end
% hold off
%%
FailResult=Judge(ndata); %�ж��Ƿ�����˨ȱʧ
%%
 %imagesc(data);
%data=dataL(:,200:340);
% �����ͣ��ٸ�ʴ����������
% ����С�ڽṹԪw������ϸ�ڣ�ͬʱ�������еĻҶȣ�����֤�ϴ�������������ո���
%w=[123,123];
%d1 = minfilt2(data,w);
%d2 = maxfilt2(d1,w);
%data(d2 <20)=0;
% �ȸ�ʴ�������͡��ղ�����ȥ���ȽṹԪС�ĺڰ�ϸ�ڡ�
%w=[63,63];
%d1 = minfilt2(data,w);%minfilt2  �Ǿֲ���С���ӣ� Ҳ����ƽ�ĻҶȸ�ʴ��
%d2 = maxfilt2(d1,w);%maxfilt2�Ǿֲ�������ӣ�Ҳ����ƽ�ĻҶ����͡�maxfilt2 ��ʹ�õ�van Herk algorithm���ٶȺܿ죬��Ϊ����������⣬��Ĵ�������
%%
%d=data;
%d((data-d2) < 90)=0;
% figure;




%% ��һ�ε���������fastener�������߾�����ⲻ���������Ұ�ߺ����ԣ���ʵ�Ҿ���ֻҪ�а���ڣ���ô����fastnerҲ��һ�����ˣ������������ų��ܶ�ĸ��š�
%d3=d;
%d3(:,240:340)=0;
%d3(:,1690:1760)=0;
%d=d-d3;
%save=d;
%% 

%% ȥ����fastener ��ͬһ�е�һЩ��������Щ������С
%w=[5,5];
%d= maxfilt2(d,w);
%d = maxfilt2(d,w);
%% ����fastener������������ͨ�ĸ���,��Ϊfastener�����з�϶��
%w=[173,173];
%d= maxfilt2(d,w);
%imwrite(save,'c:\1.jpg');
%% ��������


%I=d;

%I1 = ind2gray(I,colormap(gray)); 


%I2 = medfilt2(I1); 
%bw = im2bw(I2, graythresh(I2));

%[L, n]=bwlabel(bw, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n
%stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
%Cen = cat(1, stats.Centroid); % regionprops Centroid Ϊ��ǳ����region��property�� centroidΪ���ĵ�property

%%
%imagesc(d);
% plot(Cen(:, 1), Cen(:, 2), 'r+');
%str = sprintf('there is %d fastners', n);





