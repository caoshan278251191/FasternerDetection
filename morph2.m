function [d]= morph2(FilePath)
FilePath='E:\LCM\';
[dataL,dataR]=loadSections(FilePath,1:3,'RectifiedRngIm');
%%
dataL1=dataL(:,1:1020);
dataR = fliplr(dataR);   %������dataR���ҷ�ת
dataR1=dataR(:,1021:2040);
data=[dataL1,dataR1];
data1=data;
%%
 %imagesc(data);
%data=data(:,140:500);
% �����ͣ��ٸ�ʴ����������
% ����С�ڽṹԪw������ϸ�ڣ�ͬʱ�������еĻҶȣ�����֤�ϴ�������������ո���
w=[123,123];
d1 = minfilt2(data,w);
d2 = maxfilt2(d1,w);
%%
data(d2 <20)=0;
%% �ȸ�ʴ�������͡��ղ�����ȥ���ȽṹԪС�ĺڰ�ϸ�ڡ�
w=[63,63];
d1 = minfilt2(data,w);%minfilt2  �Ǿֲ���С���ӣ� Ҳ����ƽ�ĻҶȸ�ʴ��
d2 = maxfilt2(d1,w);%maxfilt2�Ǿֲ�������ӣ�Ҳ����ƽ�ĻҶ����͡�maxfilt2 ��ʹ�õ�van Herk algorithm���ٶȺܿ죬��Ϊ����������⣬��Ĵ�������
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
